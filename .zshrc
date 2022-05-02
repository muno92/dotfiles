# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"
. /opt/homebrew/opt/asdf/libexec/asdf.sh
eval "$(direnv hook zsh)"
setopt share_history
setopt extended_history

alias history='history -i'

alias sleepon='sudo pmset -a disablesleep 0'
alias sleepoff='sudo pmset -a disablesleep 1'

# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/zshrc.post.zsh"
