export ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.dotfiles/files/zsh/custom

ZSH_THEME="agnoster"

source $ZSH/oh-my-zsh.sh

plugins=(git node gulp grunt git-flow git-hubflow ssh-agent docker z)

. `brew --prefix`/etc/profile.d/z.sh

source ~/.dotfiles/files/zsh/export.zsh
source ~/.dotfiles/files/zsh/alias.zsh
source ~/.dotfiles/files/zsh/functions.zsh
source ~/.dotfiles/files/zsh/history.zsh
source <(npm completion)

# source ~/.iterm2_shell_integration.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Hack for apple safari'ng the bed
ssh-add -A 2>/dev/null;

# added by travis gem
[ -f /Users/manthei/.travis/travis.sh ] && source /Users/manthei/.travis/travis.sh
