#! /bin/sh

export LANG=C
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:${HOME}/.cask/bin

EMACSDIR=.emacs.d

cd "${HOME}" || exit 1

echo "Installing Cask from GitHub repository..."
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python

cd "${HOME}/${EMACSDIR}" || exit 1

echo "Installing elisp packages with Cask..."
cask install

exit 0
