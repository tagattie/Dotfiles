#! /bin/sh

export LANG=C
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

PKGS_ESSENTIAL="shells/zsh \
    devel/gmake \
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
    echo "Usage: ${CMD_NAME} [-n] essential|x11|emacs"
    echo "Options:"
    echo "  -n: Dry run."
    exit 0
}

install() {
    INSTALL_CMD="pkg install ${PKG_INSTALL_FLAG}"
    case $1 in
        "essential")
            ${INSTALL_CMD} ${PKGS_ESSENTIAL} ;;
        "x11")
            ${INSTALL_CMD} ${PKGS_X11} ;;
        "emacs")
            ${INSTALL_CMD} ${PKGS_EMACS} ;;
        *)
            print_usage
    esac
    return $?
}

while getopts n OPT; do
    case ${OPT} in
        "n")
            PKG_INSTALL_FLAG="-n"
    esac
done

shift $(($OPTIND - 1))
if [ $# -ne 1 ]; then
    print_usage
fi

install "$1"

exit $?
