# Install & init zinit if not in system
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Snippet Plugins
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found
zinit snippet OMZP::sudo
zinit snippet OMZP::kubectl
zinit snippet OMZP::gcloud
zinit snippet OMZP::aws

# load completions on startup
autoload -U compinit && compinit

zinit cdreplay -q

# keybinds
bindkey -v

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
alias cat='bat'
alias ls='eza --almost-all --group-directories-first --icons=always --long --no-permissions --no-user --no-time --no-filesize --color=always -F'
alias c='clear'
alias k='k9s'
alias pull='git pull'
alias addall='git add .'
alias addupdated='git add -u'
alias commit='git commit -m'
alias status='git status'
alias stash='git stash'
alias "clone"='git clone'
alias config-zshrc='nvim ~/.zshrc'

# shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval $(thefuck --alias)

# env 
export EDITOR=nvim

# path things
export PATH=$PATH:/home/oomkilled/.local/bin

eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/catppuccin_mocha.omp.json')"
