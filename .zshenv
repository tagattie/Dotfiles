# Environment setup file for zsh
# .zshenv

# Local variables
LOCALBASE=/usr/local
PKGBASE=/usr/pkg

# Basic
limit coredumpsize 0
umask 022

# Shell parameters
cdpath=(. .. ~)
manpath=(${LOCALBASE}/man ${PKGBASE}/man \
    /usr/share/man /usr/share/openssl/man)
path=(${HOME}/.cask/bin ${HOME}/bin \
    ${GOPATH}/bin \
    ${LOCALBASE}/bin ${PKGBASE}/bin /usr/bin /bin \
    ${LOCALBASE}/sbin ${PKGBASE}/sbin /usr/sbin /sbin)

# Environment variables
export GOPATH=${HOME}/share/go
export GOROOT=${LOCALBASE}/go
export MOZILLA_HOME=${LOCALBASE}
export NOTI_DEFAULT="banner slack"
export NOTI_SLACK_CHANNEL="#noti"
export PAGER=less
export QTDIR=${LOCALBASE}
export TMPDIR=/tmp
export XWINHOME=${LOCALBASE}
if [[ -x ${LOCALBASE}/bin/emacs &&
	      $(pgrep emacs | wc -l) -gt 0 ]]; then
    [[ -z ${DISPLAY} ]] && export EDITOR=emacsclient-nw.sh
    [[ -z ${DISPLAY} ]] || export EDITOR=emacsclient
else
    export EDITOR=vi
fi

[[ -f ${HOME}/.zshenv.local ]] && source ${HOME}/.zshenv.local

# Local Variables:
# mode: shell-script
# End:
