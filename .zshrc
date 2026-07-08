# Install & init zinit if not in system
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# load completions on startup, but only rebuild the dump once a day
zicompinit_cached() {
  autoload -Uz compinit
  local -a fresh=(~/.zcompdump(Nmh-24))
  if (( ${#fresh} )); then compinit -C; else compinit; fi
}

zinit wait lucid for \
  atinit"zicompinit_cached" \
    OMZP::git \
    OMZP::command-not-found \
    OMZP::sudo \
    OMZP::kubectl \
    OMZP::kubectx \
    OMZP::gcloud \
    OMZP::aws \
  blockf \
    zsh-users/zsh-completions \
  Aloxaf/fzf-tab \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  atinit"zicdreplay" \
    zsh-users/zsh-syntax-highlighting

# keybinds
# bindkey -v

# history management
HISTSIZE=5000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --almost-all --group-directories-first --icons=always --long --no-permissions --no-user --no-time --no-filesize --color=always -F $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --almost-all --group-directories-first --icons=always --long --no-permissions --no-user --no-time --no-filesize --color=always -F $realpath'

# aliases
command -v bat &> /dev/null && alias cat='bat'
command -v eza &> /dev/null && alias ls='eza --almost-all --group-directories-first --icons=always --long --no-permissions --no-user --no-time --no-filesize --color=always -F'
alias c='clear'
command -v k9s &> /dev/null && alias k='k9s'
alias pull='git pull'
alias addall='git add .'
alias addupdated='git add -u'
alias commit='git commit -m'
alias status='git status'
alias stash='git stash'
alias push='git push'
alias pull='git pull'
alias "clone"='git clone'
command -v nvim &> /dev/null && alias config-zshrc='nvim ~/.zshrc'
command -v kubectl &> /dev/null && alias kc='kubectl'
command -v kitty &> /dev/null && [[ "$TERM" == "xterm-kitty" ]] && alias ssh='kitty +kitten ssh'

# shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval $(thefuck --alias)

# env 
export EDITOR=nvim

# path things
export PATH=$PATH:/home/oomkilled/.local/bin

eval "$(oh-my-posh init zsh --config "$HOME/.config/oh-my-posh/config.omp.json")"
