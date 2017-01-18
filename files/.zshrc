export ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.dotfiles/files/zsh/custom

# source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

ZSH_THEME="agnoster"

source $ZSH/oh-my-zsh.sh

plugins=(git node npm gulp grunt git-flow git-hubflow ssh-agent docker z)

. `brew --prefix`/etc/profile.d/z.sh

source ~/.dotfiles/files/zsh/export.zsh
source ~/.dotfiles/files/zsh/alias.zsh
source ~/.dotfiles/files/zsh/functions.zsh
source ~/.dotfiles/files/zsh/history.zsh
# source ~/.iterm2_shell_integration.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# added by travis gem
[ -f /Users/manthei/.travis/travis.sh ] && source /Users/manthei/.travis/travis.sh
