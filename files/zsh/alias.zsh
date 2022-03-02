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

# Time Machine
# -------------------------------------------------------------------
alias ltmx="mdfind -onlyin . 'com_apple_backup_excludeItem = com.apple.backupd'"
alias ltmxg="mdfind 'com_apple_backup_excludeItem = com.apple.backupd'"

# Miscellaneous
# -------------------------------------------------------------------

alias ffd="open -n /Applications/FirefoxDeveloper.app --args -P developer -no-remote"

alias ip="dig +short myip.opendns.com @resolver1.opendns.com"		# Get your current public IP

alias stfu="osascript -e 'set volume output muted true'"		# mute the system volume

alias tmlog="syslog -F '\$Time \$Message' -k Sender com.apple.backupd-auto -k Time ge -30m | tail -n 1"		# time machine log

alias cpwd='pwd|tr -d "\n"|pbcopy'	# copy the working directory path

alias flush="sudo killall -HUP mDNSResponder"		# DNS (with update thanks to @blanco)

alias ping='/sbin/ping -c 3'	# Limit ping to 3 pings only

alias web='/usr/local/bin/http-server'	# Serve current directory

alias chromed='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222'

alias lsh='history | tail -n 20'

# Tip 'o the hat to Jesse https://github.com/jesselang/dotfiles/blob/master/profiles/_os/darwin/aliases
alias reload-camera='sudo killall AppleCameraAssistant;sudo killall VDCAssistant'

alias gtc="git town config"

alias brnx=" echo '\nvdl-nx-1' && git -C ~/code/vdl-nx-1 br && echo '\nvd-nx-2' && git -C ~/code/vdl-nx-2 br && echo '\nvdl-nx-3' && git -C ~/code/vdl-nx-3 br && echo '\nvdl-nx-4' && git -C ~/code/vdl-nx-4 br && echo '\nvdl-nx-master' && git -C ~/code/vdl-nx-master br && echo '\nvdl-nx-8.x' && git -C ~/code/vdl-nx-8.x br && echo '\nmaterial-components' && git -C ~/code/material-components br && echo '\nmaterial2' && git -C ~/code/material2 br && echo ''"

alias brvdl="echo '\nvdl-angular-1' &&  git -C ~/code/vdl-angular-1 br && echo '\nvdl-angular-2' && git -C ~/code/vdl-angular-2 br && echo '\nvdl-angular-3' && git -C ~/code/vdl-angular-3 br && echo '\nvdl-angular-4' && git -C ~/code/vdl-angular-4 br && echo '\nmaterial2' && git -C ~/code/material2 br && echo '\nvdl-angular-master' && git -C ~/code/vdl-angular-master br && echo ''"

# Use git town prune-branches to clean up clones
alias prbrnx="echo '\nvdl-nx-1' && git -C ~/code/vdl-nx-1 town prune-branches && echo '\nvdl-nx-2' && git -C ~/code/vdl-nx-2 town prune-branches && echo '\nvdl-nx-3' && git -C ~/code/vdl-nx-3 town prune-branches && echo '\nvdl-nx-4' && git -C ~/code/vdl-nx-4 town prune-branches && echo '\nvdl-nx-8.x' && git -C ~/code/vdl-nx-8.x town prune-branches"

# Use git town prune-branches to clean up clones
alias prbrvdl="echo '\nvdl-nx-1' && git -C ~/code/vdl-nx-1 town prune-branches && echo '\nvdl-nx-2' && git -C ~/code/vdl-nx-2 town prune-branches && echo '\nvdl-nx-3' && git -C ~/code/vdl-nx-3 town prune-branches && echo '\nvdl-nx-4' && git -C ~/code/vdl-nx-4 town prune-branches && echo '\nvdl-angular-1' && git -C ~/code/vdl-angular-1 town prune-branches && echo '\nvdl-angular-2' && git -C ~/code/vdl-angular-2 town prune-branches && echo '\nvdl-angular-3' && git -C ~/code/vdl-angular-3  town prune-branches && echo '\nvdl-angular-4' && git -C ~/code/vdl-angular-4 town prune-branches"
