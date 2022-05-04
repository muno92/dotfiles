
# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"

# Powerlevel10k用のフォントが設定されているAlacritty以外で表示が崩れないよう、AlacrittyでのみPowerlevel10kを有効にする
SHELL_OPENER=$(ps -p $(ps axo pid,ppid | awk -v CURRENT_PID=$$ 'BEGIN { pid = CURRENT_PID } { parent[$1] = $2 } END { while(parent[pid] != 1) { pid = parent[pid] } print pid }') -o comm=)
ENABLE_POWERLEVEL10K=$(if grep -lq alacritty $SHELL_OPENER; then echo 'TRUE'; else echo 'FALSE'; fi)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ "${ENABLE_POWERLEVEL10K}" = 'TRUE' && -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

. /opt/homebrew/opt/asdf/libexec/asdf.sh
eval "$(direnv hook zsh)"
setopt share_history
setopt extended_history

alias history='history -i'

alias sleepon='sudo pmset -a disablesleep 0'
alias sleepoff='sudo pmset -a disablesleep 1'

[[ "${ENABLE_POWERLEVEL10K}" = 'TRUE' ]] && source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ "${ENABLE_POWERLEVEL10K}" = 'TRUE' ]] && [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/zshrc.post.zsh"
