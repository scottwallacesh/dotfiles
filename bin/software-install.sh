#!/bin/bash

#-------------------------------
# Check OS
#-------------------------------
if [ $(uname -s) != "Darwin" ]; then
    echo "This should only run on Mac OS X."
    exit 1
fi
#-------------------------------

#-------------------------------
# Install Homebrew if missing
#-------------------------------
if [ ! -x /usr/local/bin/brew ]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
#-------------------------------

#-------------------------------
# Install the basics
#-------------------------------
xargs brew install <<EOF
    git
    coreutils
    htop
    python3
    vim
EOF
#-------------------------------

#-------------------------------
# Install Casks
#-------------------------------
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
#-------------------------------