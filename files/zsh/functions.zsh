
# -------------------------------------------------------------------
# cd to the path of the front Finder or Path Finder window
# from http://brettterpstra.com/2013/02/09/quick-tip-jumping-to-the-finder-location-in-terminal/
# -------------------------------------------------------------------
cdf() { # Finder
	target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
	if [ "$target" != "" ]; then
		cd "$target"; pwd
	else
		echo 'No Finder window found' >&2
	fi
}
cdpf() { # Path Finder
	target=`osascript -e 'tell application "Path Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of the front finder window)'`
	if [ "$target" != "" ]; then
		cd "$target"; pwd
	else
		echo 'No Path Finder window found' >&2
	fi
}

# -------------------------------------------------------------------
# From http://brettterpstra.com/a-simple-but-handy-bash-function-console/
# -------------------------------------------------------------------
function console () {
  if [[ $# > 0 ]]; then
    query=$(echo "$*"|tr -s ' ' '|')
    tail -f /var/log/system.log|grep -i --color=auto -E "$query"
  else
    tail -f /var/log/system.log
  fi
}

# -------------------------------------------------------------------
# From http://brettterpstra.com/2015/04/27/a-universal-clipboard-command-for-bash/
# -------------------------------------------------------------------
copy() {
	if [[ $1 =~ ^-?[hH] ]]; then

		echo "Intelligently copies command results, text file, or raw text to"
		echo "OS X clipboard"
		echo
		echo "Usage: copy [command or text]"
		echo "  or pipe a command: [command] | copy"
		return
	fi

	local output
	local res=false
	local tmpfile="${TMPDIR}/copy.$RANDOM.txt"
	local msg=""

	if [[ $# == 0 ]]; then
		output=$(cat)
		msg="Input copied to clipboard"
		res=true
	else
		local cmd=""
		for arg in $@; do
			cmd+="\"$(echo -en $arg|sed -E 's/"/\\"/g')\" "
		done
		output=$(eval "$cmd" 2> /dev/null)
		if [[ $? == 0 ]]; then
			msg="Results of command are in the clipboard"
			res=true
		else
			if [[ -f $1 ]]; then
				output=""
				for arg in $@; do
					if [[ -f $arg ]]; then
						type=`file "$arg"|grep -c text`
						if [ $type -gt 0 ]; then
							output+=$(cat $arg)
							msg+="Contents of $arg are in the clipboard.\n"
							res=true
						else
							msg+="File \"$arg\" is not plain text.\n"
						fi
					fi
				done
			else
				output=$@
				msg="Text copied to clipboard"
				res=true
			fi
		fi
	fi

	$res && echo -ne "$output" | pbcopy -Prefer txt
	echo -e "$msg"
}

# -------------------------------------------------------------------
# Functions for searching
# See qfind alias in alias.zsh
# -------------------------------------------------------------------
ff()  { /usr/bin/find . -name "$@" ; }			# ff:		Find file under the current directory
ffs() { /usr/bin/find . -name "$@"'*' ; }	# ffs:	Find file whose name starts with a given string
ffe() { /usr/bin/find . -name '*'"$@" ; }	# ffe:	Find file whose name ends with a given string

# -------------------------------------------------------------------
# https://github.com/ttscoff/dotfiles/blob/master/.bash_profile
# -------------------------------------------------------------------
fp () { #find and list processes matching a case-insensitive partial-match string
    ps Ao pid,comm|awk '{match($0,/[^\/]+$/); print substr($0,RSTART,RLENGTH)": "$1}'|grep -i $1|grep -v grep
}

# -------------------------------------------------------------------
# https://hanckmann.com/2015/08/12/Remove-line-from-zsh-history.html
# -------------------------------------------------------------------
histrm() { LC_ALL=C sed -i '' /$1/d $HISTFILE }

# -------------------------------------------------------------------
# https://gist.github.com/jimbojsb/1630790
# -------------------------------------------------------------------
function light() {
  if [ -z "$2" ]
    then src="pbpaste"
  else
    src="cat $2"
  fi
  $src | highlight -O rtf --syntax $1 --font Inconsolata --style solarized-dark --font-size 24 | pbcopy
  # $src | highlight -O rtf --syntax $1 | pbcopy
}

# -------------------------------------------------------------------
# ls node packages, works with -g
# -------------------------------------------------------------------
lsn() {
	npm list $1 --depth=0
}

# -------------------------------------------------------------------
# List files with specified Finder tags in current directory and subdirectories
# Works with partial words starting from the beginning of the word
# -------------------------------------------------------------------
lst() {
	local query
	# if the first argument is "all" (case insensitive),
	# a boolean AND search will be used. Defaults to OR.
	bool="OR"
	[[ $1 =~ "all" ]] && bool="AND" && shift

	# if there's no argument or the argument is "+"
	# list all files with any tags
	if [[ -z $1 || $1 == "+" ]]; then
		query="kMDItemUserTags == '*'"
	# if the first argument is "-"
	# list only files without tags
	elif [[ $1 == "-" ]]; then
		query="kMDItemUserTags != '*'"
	# Otherwise, build a Spotlight syntax query string
	else
		query="tag:$1"
		shift
		for tag in $@; do
			query="$query $bool tag:$tag"
		done
	fi

	while IFS= read -r -d $'\0' line; do
		echo ${line#`pwd`/}
	done < <(mdfind -onlyin . -0 "$query")
}

# -------------------------------------------------------------------
# ls archives (inspired by `extract`)
# -------------------------------------------------------------------
lsz() {
	if [ $# -ne 1 ]
	then
		echo "lsz filename.[tar,tgz,gz,zip,etc]"
		return 1
	fi
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2|*.tar.gz|*.tar|*.tbz2|*.tgz) tar tvf $1;;
			*.zip)  unzip -l $1;;
			*)      echo "'$1' unrecognized." ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# -------------------------------------------------------------------
# myIP address
# http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/
# -------------------------------------------------------------------
myip() {
  ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
  ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}

# -------------------------------------------------------------------
# nice mount (http://catonmat.net/blog/another-ten-one-liners-from-commandlingfu-explained)
# displays mounted drive information in a nicely formatted manner
# -------------------------------------------------------------------
nicemount() {
	(echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2="";1') | column -t ;
}

# -------------------------------------------------------------------
# display a neatly formatted path
# http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/
# -------------------------------------------------------------------
path() {
  echo $PATH | tr ":" "\n" | \
    awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
           sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
           sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
           sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
           sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
           print }"
}

# -------------------------------------------------------------------
# https://github.com/ttscoff/dotfiles/blob/master/.bash_profile
# -------------------------------------------------------------------
pman () { #display man page as a PostScript PDF in Preview.app
  man -t "$1"|open -f -a "Preview.app"
}

# -------------------------------------------------------------------
# Print horizontal ruler
# http://brettterpstra.com/2015/02/20/shell-trick-printf-rules/
# -------------------------------------------------------------------
rule () {
	_hr=$(printf "%*s" $(tput cols)) && echo ${_hr// /${1--}}
}

# Print horizontal ruler with message
rulem ()  {
	if [ $# -eq 0 ]; then
		echo "Usage: rulem MESSAGE [RULE_CHARACTER]"
		return 1
	fi
	# Fill line with ruler character ($2, default "-"), reset cursor, move 2 cols right, print message
	_hr=$(printf "%*s" $(tput cols)) && echo -en ${_hr// /${2--}} && echo -e "\r\033[2C$1"
}

sman () { #open man page in sublime
  MANWIDTH=160 MANPAGER='col -bx' man $@ | subl
}

# -------------------------------------------------------------------
# Clear download history
# https://www.macobserver.com/tips/how-to/your-mac-remembers-everything-you-download-heres-how-to-clear-download-history/
# -------------------------------------------------------------------
cdlh() {
	sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV2 'delete from LSQuarantineEvent'
	sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV2 'vacuum LSQuarantineEvent'
}
ldlh() {
	sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV2 'select LSQuarantineDataURLString from LSQuarantineEvent where LSQuarantineDataURLString != ""'
}