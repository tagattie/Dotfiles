# Setup file for zsh
# .zshrc

# Basic
PS1='[%n@%m]%~:zsh %h%(!.#.$) '
WORDCHARS='*?_-.[]=&!#$%^(){}<>'
setopt auto_cd
setopt auto_pushd
setopt cdable_vars
setopt pushd_ignore_dups
setopt pushd_silent
setopt pushd_to_home
setopt extended_glob
setopt correct
setopt correct_all
setopt ignore_eof
setopt interactive_comments
setopt print_eight_bit
setopt print_exit_value
setopt auto_resume
setopt notify
setopt multios
unsetopt beep

# Key bindings
bindkey -e

# Colors
autoload -Uz colors && colors

# Completion
autoload -U compinit && compinit
setopt complete_aliases
setopt glob_complete
unsetopt list_beep
setopt list_packed
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# History
HISTFILE=${HOME}/.zhistory
HISTSIZE=50000
SAVEHIST=50000
unsetopt hist_beep
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history

# VCS info
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT='${vcs_info_msg_0_}'

# Zmv
autoload -Uz zmv

# Aliases
alias bzip2='bzip2 -9vv'
alias cd..='cd ..'
alias cp='cp -i'
alias gco='git checkout'
alias gmerge='git merge'
alias gpull='git pull'
alias gpush='git push'
alias gst='git status'
alias h=history
alias j='jobs -l'
alias l='\ls -ailFGT'
alias la='\ls -aFG'
alias ls='\ls -FG'
alias md=mkdir
alias mv='mv -i'
alias q=exit
alias rd=rmdir
alias rm='rm -i'
alias tset='set noglob histchars=""; eval `\tset -s \!*`; unset noglob histchars'
alias where='type -a'
alias xinit='\xinit > ${HOME}/.xinit-errors 2>&1'

# Zplug plugin manager
if [[ -x ${HOME}/.zplug ]]; then
    export ZPLUG_HOME=${HOME}/.zplug
    source ${ZPLUG_HOME}/init.zsh
    zplug "mollifier/anyframe"
    zplug "b4b4r07/enhancd", use:init.sh
    zplug "marzocchi/zsh-notify"
    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-completions"
    zplug "zsh-users/zsh-syntax-highlighting", defer:2
    zplug check || zplug install
    zplug load
fi

# Anyframe
bindkey '^xb' anyframe-widget-cdr
bindkey '^x^b' anyframe-widget-checkout-git-branch
bindkey '^xr' anyframe-widget-execute-history
bindkey '^x^r' anyframe-widget-execute-history
bindkey '^xp' anyframe-widget-put-history
bindkey '^x^p' anyframe-widget-put-history
bindkey '^xg' anyframe-widget-cd-ghq-repository
bindkey '^x^g' anyframe-widget-cd-ghq-repository
bindkey '^xk' anyframe-widget-kill
bindkey '^x^k' anyframe-widget-kill
bindkey '^xi' anyframe-widget-insert-git-branch
bindkey '^x^i' anyframe-widget-insert-git-branch
bindkey '^xf' anyframe-widget-insert-filename
bindkey '^x^f' anyframe-widget-insert-filename

# Enhancd
export ENHANCD_FILTER=peco

# Zsh-notify
zstyle ':notify:*' notifier /usr/local/bin/notify-send

[[ -f ${HOME}/.zshrc.local ]] && source ${HOME}/.zshrc.local

# Setting for Emacs TRAMP
[[ ${TERM} == "dumb" ]] && unsetopt zle && PS1='$ '

# Local Variables:
# mode: shell-script
# End:
