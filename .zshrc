fortune | fumosay -f marisa
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# colors
autoload -U colors && colors

# emacs mode
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

# history search
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Aliases
alias l='ls -l'
# alias vim='nvim'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias zt='zathura'
alias nv='nvim'
alias fzf='fzf --preview="bat --color=always {}"'
alias t='hyprsunset -t';
alias fetch='fastfetch'
alias y='yazi'

# defines
export EDITOR=nvim

# === zinit config ===

# set dir
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# source
source "${ZINIT_HOME}/zinit.zsh"

# = plugins =
# powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# load completions
autoload -U compinit && compinit

zinit cdreplay -q
# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completion style
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
