#!/bin/sh
PANEL_FIFO=/tmp/panel-fifo
DWMBLOCKS=$HOME/.config/dwmblocks

[ -e $PANEL_FIFO ] && rm $PANEL_FIFO
mkfifo $PANEL_FIFO

xrandr -s 1920x1080 -r 240
$HOME/.fehbg
xsetroot -cursor_name left_ptr
pipewire &
compton -f &

$DWMBLOCKS/sound.sh > $PANEL_FIFO &
$DWMBLOCKS/clock.sh > $PANEL_FIFO &
$DWMBLOCKS/memory.sh > $PANEL_FIFO &
$DWMBLOCKS/storage.sh > $PANEL_FIFO &
$DWMBLOCKS/cpu.sh > $PANEL_FIFO &

$HOME/.dwmblocks $PANEL_FIFO &
exec dwm
