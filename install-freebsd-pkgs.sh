#! /bin/sh

export LANG=C
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

PKGS_ESSENTIAL="shells/zsh \
    lang/python \
    security/sudo \
    misc/lv \
    sysutils/byobu \
    sysutils/tmux \
    ftp/curl \
    net/rsync \
    devel/git"
PKGS_X11="x11/xorg \
    x11/mate \
    x11/xscreensaver \
    x11-fonts/noto \
    japanese/font-std \
    japanese/ibus-mozc"
PKGS_EMACS="editors/emacs \
    japanese/mozc-el"

CMD_NAME=$(basename "$0")
print_usage() {
    echo "Usage: ${CMD_NAME} essential|x11|emacs"
    exit 0
}

install() {
    case $1 in
        "essential")
            pkg install ${PKGS_ESSENTIAL} ;;
        "x11")
            pkg install ${PKGS_X11} ;;
        "emacs")
            pkg install ${PKGS_EMACS} ;;
        *)
            print_usage
    esac
    return $?
}

if [ $# -ne 1 ]; then
    print_usage
fi

install "$1"
exit $?
