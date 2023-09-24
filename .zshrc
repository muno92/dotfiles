IS_MAC='false'
if [[ $(uname) == 'Linux' ]]; then
    # brew --prefixは実行に時間が掛かるので固定値で持つ
    BREW_PREFIX='/home/linuxbrew/.linuxbrew'
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    BREW_PREFIX='/opt/homebrew'
    IS_MAC='true'
fi

if [[ ${IS_MAC} == 'true' ]]; then
     # Fig pre block. Keep at the top of this file.
    . "$HOME/.fig/shell/zshrc.pre.zsh"
fi

fpath=(${BREW_PREFIX}/share/zsh/site-functions $fpath)
autoload -Uz compinit
compinit

# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-max 1000
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"

function peco-cdr () {
    local selected_dir="$(cdr -l | awk '{ print $2 }' | peco)"
    if [[ -n ${selected_dir} ]]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-cdr
# zshのキーバインドで余っているキー && 打ちやすいキー
bindkey '^Y' peco-cdr

# 便利ツール
. ${BREW_PREFIX}/opt/asdf/libexec/asdf.sh
eval "$(direnv hook zsh)"

# historyを見やすくする
export SAVEHIST=1000
export HISTSIZE=2000
export HISTFILE="${HOME}/.zsh_history"
setopt share_history
setopt extended_history
alias history='history -i'

if [[ ${IS_MAC} == 'true' ]]; then
    . ~/.zshrc_mac
fi

# プロンプトにユーザー名・PC名が表示されなくなりさえすれば良いので、pureを使うのでは無くPROMPTをカスタマイズする
export PROMPT='%~ %F{yellow}>%f '

# docker composeで起動したコンテナに簡単にログインするための関数
function dce() {
    local services=$(docker compose ps --services --status running)
    [[ -n ${services} ]] || return

    local service=$(echo "${services}" | peco --select-1 --prompt 'Select Container >')
    [[ -n ${service} ]] || return

    # コンテナによってはbashが使えないので、シェルも選択式にする
    local shells=$(docker compose exec "${service}" grep -E '^[a-z/]+$' /etc/shells)
    [[ -n ${shells} ]] || return

    local shell=''
    if [[ $shells =~ /zsh ]]; then
        echo 'Use zsh'
        shell='zsh'
    elif [[ $shells =~ /bash ]]; then
        echo 'Use bash'
        shell='bash'
    elif [[ $shells =~ /sh ]]; then
        echo 'Use sh'
        shell='sh'
    else
        shell=$(echo "${shells}" | peco --select-1 --prompt 'Select Shell >')
    fi

    [[ -n ${shell} ]] && docker compose exec "${service}" "${shell}"
}

alias dc='docker compose'
alias e='exa'

# コマンド実行履歴をzsh標準機能ではなくpecoで検索出来るようにする
function peco-history-selection() {
    # zshのhistoryなら-rで逆順に出来る
    # https://linux.die.net/man/1/zshbuiltins
    BUFFER=$(\history -r -n 1 | awk '!a[$0]++' | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$PATH"

export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"

export LESS='-g -i -M -R'

if [[ ${IS_MAC} == 'true' ]]; then
    # Fig post block. Keep at the bottom of this file.
    . "$HOME/.fig/shell/zshrc.post.zsh"
fi
