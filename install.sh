#! /bin/sh

# Check necessary packages are installed
PREREQUISITE_CMDS="git zsh python curl"
for i in ${PREREQUISITE_CMDS}; do
    which "${i}" > /dev/null 2>&1; NOT_FOUND=$?
    if [ $NOT_FOUND -ne 0 ]; then
        echo "$0: ${i} is not found."
        exit 1
    fi
done

# Install Emacs-related files
EMACS_INIT_DIR=".emacs.d"
EMACS_INIT_FILES="Cask init.el"
mkdir -p "${HOME}/${EMACS_INIT_DIR}"
for i in ${EMACS_INIT_FILES}; do
#    echo "$(pwd)/${EMACS_INIT_DIR}/${i} -> ${HOME}/${EMACS_INIT_DIR}/${i}"
    ln -sfv "$(pwd)/${EMACS_INIT_DIR}/${i}" "${HOME}/${EMACS_INIT_DIR}/${i}"
done

# Install other files
RCFILES=".??*"
for i in ${RCFILES}; do
    if [ "${i}" = ".emacs.d" ] ||
           [ "${i}" = ".git" ] ||
           [ "${i}" = ".gitignore" ]; then
        continue
    fi
#    echo "$(pwd)/${i} -> ${HOME}/${i}"
    ln -sfv "$(pwd)/${i}" "${HOME}/${i}"
done

# Guide for installing external dependencies
echo "To install Cask, do the following command:"
echo "curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python"
echo "To install zplug, do the following command:"
echo "curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh"

exit 0
