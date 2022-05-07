 # Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"

if [[ "${ENABLE_POWERLEVEL10K}" = 'true' && -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

. /opt/homebrew/opt/asdf/libexec/asdf.sh
eval "$(direnv hook zsh)"
setopt share_history
setopt extended_history

alias history='history -i'

alias sleepon='sudo pmset -a disablesleep 0'
alias sleepoff='sudo pmset -a disablesleep 1'

[[ "${ENABLE_POWERLEVEL10K}" = 'true' ]] && source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ "${ENABLE_POWERLEVEL10K}" = 'true ' ]] && [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/zshrc.post.zsh"
