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
alias h=history
alias j='jobs -l'
alias l='\ls -agilFGT'
alias la='\ls -aFG'
alias less=lv
alias ls='\ls -FG'
alias md=mkdir
alias mv='mv -i'
alias q=exit
alias rd=rmdir
alias rm='\rm -i'
alias where='type -a'
alias xinit='\xinit > ${HOME}/.xinit-errors 2>&1'

# Zplug plugin manager
export ZPLUG_HOME=${HOME}/.zplug
source ${ZPLUG_HOME}/init.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug check || zplug install
zplug load

[[ -f ${HOMER}/.zshrc.local ]] && source ${HOME}/.zshrc.local

# Setting for Emacs TRAMP
[[ ${TERM} == "dumb" ]] && unsetopt zle && PS1='$ '
