# Setup file for csh
# .cshrc

# Local variables
set LOCALBASE=/usr/local
set PKGBASE=/usr/pkg

# Basic
limit coredumpsize 0
umask 022

# Environment variables
setenv GOPATH       ${HOME}/share/go
setenv GOROOT       ${LOCALBASE}/go
setenv HOST         `hostname -s`
setenv MANPATH      "${LOCALBASE}/man:${PKGBASE}/man:/usr/share/man:/usr/share/openssl/man"
setenv MOZILLA_HOME ${LOCALBASE}
setenv PAGER        less
setenv QTDIR        ${LOCALBASE}
setenv TMPDIR       /tmp
setenv XWINHOME     ${LOCALBASE}
if ( -x ${LOCALBASE}/bin/emacs ) then
    setenv EDITOR   emacsclient
else
    setenv EDITOR   vi
endif

# Shell variables
set cdpath=(. .. ~)
set color
set filec
set history=50000
set savehist=50000
set ignoreeof=0
set notify
set path=(${HOME}/.cask/bin ${HOME}/bin \
    ${GOPATH}/bin \
    ${LOCALBASE}/bin ${PKGBASE}/bin /usr/bin /bin \
    ${LOCALBASE}/sbin ${PKGBASE}/sbin /usr/sbin /sbin)

# Aliases
alias bzip2  'bzip2 -9vv'
alias cd     'cd \!* ; set prompt = "[${user}@${HOST}]`pwd`:\\!% "'
alias cd..   'cd ..'
alias cp     'cp -i'
alias gco    'git checkout'
alias gmerge 'git merge'
alias gpull  'git pull'
alias gpush  'git push'
alias gst    'git status'
alias h      history
alias j      'jobs -l'
alias l      '\ls -agilFT'
alias la     '\ls -aF'
alias ls     '\ls -F'
alias md     mkdir
alias mv     'mv -i'
alias popd   'popd \!*; set prompt = "[${user}@${HOST}]`pwd`:\\!% "'
alias pushd  'pushd \!*; set prompt = "[${user}@${HOST}]`pwd`:\\!% "'
alias q      exit
alias rd     rmdir
alias rm     'rm -i'
alias xinit  '\xinit >& ${HOME}/.xinit-errors'

# Interactive shell
if ( $?prompt ) then
    stty erase ^H
    set prompt = "[${user}@${HOST}]`pwd`:csh \!% "
endif

# Local Variables:
# mode: shell-script
# End:
