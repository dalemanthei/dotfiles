# Tip of the hat to:
# Terpstra aliases http://brettterpstra.com/2013/03/31/a-few-more-of-my-favorite-shell-aliases/

alias qlock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend%"

# find commands, see also ff, ffs, ffe functions in functions.zsh
# -------------------------------------------------------------------
alias qfind="find . -name "	# qfind:    Quickly search for file

# Flip side of cdf() and cdpf() in functions.zsh
# -------------------------------------------------------------------
alias f='open -a Finder ./'					# flip side of cdf()
alias pf='open -a "Path Finder" ./' # flip side of cdpf()

# -------------------------------------------------------------------
alias cl="fc -e -|pbcopy"	# copy output of last command to clipboard

alias cpu='top -o cpu'		# top
alias mem='top -o rsize'	# memory

alias ql="qlmanage -p &>/dev/null"	# launch quicklook on selected file

# Better ls commands
# -------------------------------------------------------------------
alias ll="ls -Al"					# list everything in long format
alias ld="ls -ld */"			# list only directories
alias lf="ls -l *(.)"			# list only regular files
alias ldf="ls -Ald .*"		# list only dotfiles
alias lt='ls -Alt && echo "------Oldest--"'		# list newest first
alias ltr='ls -Alrt && echo "------Newest--"' # list oldest first

# Miscellaneous
# -------------------------------------------------------------------

alias ip="dig +short myip.opendns.com @resolver1.opendns.com"		# Get your current public IP

alias stfu="osascript -e 'set volume output muted true'"		# mute the system volume

alias tmlog="syslog -F '\$Time \$Message' -k Sender com.apple.backupd-auto -k Time ge -30m | tail -n 1"		# time machine log

alias cpwd='pwd|tr -d "\n"|pbcopy'	# copy the working directory path

alias flush="sudo killall -HUP mDNSResponder"		# DNS (with update thanks to @blanco)

alias ping='/sbin/ping -c 3'	# Limit ping to 3 pings only

alias web='/usr/local/bin/http-server'	# Serve current directory
