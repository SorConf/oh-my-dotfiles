# ███████╗░██████╗██╗░░██╗██████╗░░█████╗░
# ╚════██║██╔════╝██║░░██║██╔══██╗██╔══██╗
# ░░███╔═╝╚█████╗░███████║██████╔╝██║░░╚═╝
# ██╔══╝░░░╚═══██╗██╔══██║██╔══██╗██║░░██╗
# ███████╗██████╔╝██║░░██║██║░░██║╚█████╔╝
# ╚══════╝╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░

# -----------------------------
# General
# -----------------------------

setopt auto_cd #cd省略
setopt no_beep #ピープ音を鳴らさないように変更
setopt auto_param_keys #括弧の対応を自動補完
setopt correct #コマンドスペルチェック
setopt correct_all #コマンドラインのスペルチェック
autoload -Uz compinit ; compinit # 自動補完
setopt complete_in_word # 単語の入力途中でもtab補完有効化
setopt correct # コマンドミスを修正
zstyle ':completion:*' menu select
setopt list_packed #補完を詰めて表示
zstyle ':completion::complete:*' use-cache true # キャッシュの利用による補完の高速化
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 大文字小文字を区別しない（入力は除外）

# -----------------------------
# Color
# -----------------------------

autoload -Uz colors ; colors #色を使用
export LSCOLORS=Exfxcxdxbxegedabagacad #色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30' # 補完時の色設定
autoload -U colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}" # 補完候補に色つける

# -----------------------------
# History
# -----------------------------

setopt share_history #他のターミナルとヒストリーを共有
setopt hist_ignore_all_dups #すでにhistoryにあるコマンドは残さない
alias h='fc -lt '%F %T' 1' #historyに日付を表示
setopt hist_reduce_blanks #ヒストリに保存するときに余分なスペースを削除する
setopt inc_append_history # 履歴をすぐに追加する
setopt hist_verify #ヒストリを呼び出してから実行する間に一旦編集できる状態になる

# -----------------------------
#  shortcut
# -----------------------------

alias tw='open -a "Twitter.app"' #ツイアプリ起動
alias slack='open -a "slack.app"' #Slack起動
alias vscode='open -a "Visual\ Studio\ Code.app"' #vscode起動
alias google='open -a "Google\ Chrome.app/"' #google起動
alias vivaldi='open -a "Vivaldi.app"' #vivaldi起動
alias safari='open -a "Safari.app"' # safari起動
alias xampp='open /Applications/XAMPP/manager-osx.app' #xampp-manager起動
alias code='open -a /Applications/Visual\ Studio\ Code.app' #vscodeで起動
alias brave='open -a "Brave Browser.app"'
alias htdocs='cd /Applications/XAMPP/htdocs/'
alias mysqld='/Applications/XAMPP/bin/mysql -u root' #XAMPP用MySQL接続
alias qiita='open https://qiita.com/ -a "Brave Browser.app"'
alias github='open https://github.com/ -a "Brave Browser.app"'
alias snote='open https://app.simplenote.com -a "Brave Browser.app"'

# -----------------------------
# command Alias
# -----------------------------

alias ls='exa'
alias ll='exa -ahl --git' #llコマンド
alias cl='clear' #clear略称
alias dnf='brew'
alias h='history'
alias to='touch'
alias b='bg'
alias f='fg'
alias g='grep'
alias cat='bat'
alias vi='vim'
alias git see='hub see'
alias vz='vim ~/.zshrc'
alias re='source ~/.zshrc'
alias see='hub see'
alias npxre='npx create-react-app '

# -----------------------------
# start shellscript
# -----------------------------

alias baks='sh ${HOME}/rep/sh/bak/starShipBak'
alias bakz='sh ${HOME}/rep/sh/bak/zshrcBak'
alias bakv='sh ${HOME}/rep/sh/bak/vimrcBak'
alias qiitad='sh ${HOME}/rep/sh/qiitaMdDownloader'

# -----------------------------
# Other
# -----------------------------

# autpLs
function chpwd() { ls }

# peco
function peco_select_history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco_select_history
bindkey '^r' peco_select_history

# cdr
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

function peco-cdr () {
    local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | peco --prompt="cdr >" --query "$LBUFFER")"
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N peco-cdr
bindkey '^e' peco-cdr

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
# call starShip
eval "$(starship init zsh)"
