#!/bin/bash

if [ ! -x /usr/local/bin/brew ]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

xargs brew install <<EOF
    git
    coreutils
    htop
    python3
    vim
EOF

xargs brew cask install <<EOF
    alfred
    bbc-iplayer-downloads
    beardedspice
    dashlane
    day-o
    dropbox
    cleanmymac
    firefox
    flux
    gitx
    gpgtools
    google-chrome
    google-drive
    google-hangouts
    gopro-studio
    handbrake
    iterm2
    sonos
    textmate
    vlc
    vmware-fusion
    wireshark
    xquartz
    yubikey-neo-manager
    yubikey-personalization-gui
EOF
