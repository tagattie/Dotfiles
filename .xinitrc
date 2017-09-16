#! /bin/sh

# Startup file for X
# .xinitrc

PREFIX="/usr/local"
BINDIR="${PREFIX}/bin"

# X preferences
setxkbmap -model jp106 \
          -layout jp \
          -option compose:rctrl \
          -option ctrl:nocaps
xset b off
xset c off
xset dpms 900 1800 3600
xset m 3 4
xset r rate 300 60

# Input method
export XIM="ibus"
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="ibus"
export XMODIFIERS="@im=ibus"
export XIM_PROGRAM="ibus-daemon"
export XIM_ARGS="-r --daemonize --xim"
${BINDIR}/mozc start
${BINDIR}/ibus-daemon -r --daemonize --xim

# Startup clients
${BINDIR}/mate-terminal --title=Login &

exec ${BINDIR}/mate-session $@
