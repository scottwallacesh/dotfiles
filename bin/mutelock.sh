#!/bin/bash
# Credit for code:
   #https://unix.stackexchange.com/users/14353/cliff-stanford
   #https://unix.stackexchange.com/users/231160/nik-gnomic
# Post on stackexchange: https://unix.stackexchange.com/questions/467456/how-to-mute-sound-when-xscreensaver-locks-screen/589614#589614

gdbus monitor -e -d org.xfce.ScreenSaver | grep ActiveChanged --line-buffered |
    while read line
    do
        case "$line" in
            *"(true,)"*)
                pactl set-sink-mute @DEFAULT_SINK@ on
            ;;
            *"(false,)"*)
                pactl set-sink-mute @DEFAULT_SINK@ off
            ;;
        esac
    done
exit
