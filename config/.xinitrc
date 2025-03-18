#!/bin/sh

# Executar script de remapeamento de teclas
~/nixos/config/xmodmap.sh &

# Iniciar o gerenciador de janelas
sxhkd &
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus
dbus-launch --exit-with-session bspwm
