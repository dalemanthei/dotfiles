
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
# Functions for searching
# See qfind alias in alias.zsh
# -------------------------------------------------------------------
ff()  { /usr/bin/find . -name "$@" ; }			# ff:		Find file under the current directory
ffs() { /usr/bin/find . -name "$@"'*' ; }	# ffs:	Find file whose name starts with a given string
ffe() { /usr/bin/find . -name '*'"$@" ; }	# ffe:	Find file whose name ends with a given string

# -------------------------------------------------------------------
# ls npm packages, add -g to see global installed packages and versions
# -------------------------------------------------------------------
lsn() {
	npm list $1 --depth=0
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
