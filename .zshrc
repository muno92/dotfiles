 # Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"

autoload -U compinit
compinit

# 便利ツール
. /opt/homebrew/opt/asdf/libexec/asdf.sh
eval "$(direnv hook zsh)"

# historyを見やすくする
setopt share_history
setopt extended_history
alias history='history -i'

alias sleepon='sudo pmset -a disablesleep 0'
alias sleepoff='sudo pmset -a disablesleep 1'

# 各種GNU系コマンドを優先して使うようにする
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"

# プロンプトにユーザー名・PC名が表示されなくなりさえすれば良いので、pureを使うのでは無くPROMPTをカスタマイズする
export PROMPT='%~ %F{yellow}>%f '

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# docker composeで起動したコンテナに簡単にログインするための関数
function dce() {
    local services=$(docker compose ps --services --status running)
    [[ -n ${services} ]] || return

    local service=$(echo ${services} | peco --select-1 --prompt 'Select Container >')
    [[ -n ${service} ]] || return

    local shells=$(docker compose exec ${service} grep -E '^[a-z/]+$' /etc/shells)
    [[ -n ${shells} ]] || return

    local shell=$(echo ${shells} | peco --select-1 --prompt 'Select Shell >')
    [[ -n ${shell} ]] && docker compose exec ${service} ${shell}
}

alias dc='docker compose'
alias e='exa'

# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/zshrc.post.zsh"
