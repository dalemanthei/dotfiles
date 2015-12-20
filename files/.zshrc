export ZSH=$HOME/.oh-my-zsh

source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

ZSH_THEME="agnoster"

source $ZSH/oh-my-zsh.sh

plugins=(git node npm bower gulp grunt git-flow git-hubflow)

source ~/.dotfiles/files/zsh/export.zsh
source ~/.dotfiles/files/zsh/alias.zsh
source ~/.dotfiles/files/zsh/functions.zsh
source ~/.dotfiles/files/zsh/history.zsh
