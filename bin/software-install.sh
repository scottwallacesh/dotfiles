#!/bin/bash

function install_linux_software {
    #-------------------------------
    # Check the OS and set install command
    #-------------------------------
    if [ -x "$(which yum)" ]; then
        INSTALLCMD="yum install -y"
    elif [ -x "$(which apt-get)" ]; then
        INSTALLCMD="apt-get install -y"
    else
        echo "Sorry, I don't know how to install software on this OS yet."
        exit 1
    fi
    #-------------------------------

    xargs sudo ${INSTALLCMD} <<-EOF
        ack
        archey
        bash-completion
        git
        htop
        mosh
        nmap
        pv
        ss
        vim
	EOF
}

function install_osx_software {
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
    xargs brew install <<-EOF
        ack
        archey
        bash-completion
        git
        coreutils
        htop-osx
        mosh
        nmap
        pv
        python3
        rename
        vim
	EOF
    #-------------------------------

    #-------------------------------
    # Install Casks
    #-------------------------------
    xargs brew cask install <<-EOF
        1password
        alfred
        bbc-iplayer-downloads
        beardedspice
        bittorrent-sync
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

    #-------------------------------
    # Clean up
    #-------------------------------
    brew cleanup
    brew cask cleanup
    #-------------------------------
}

#-------------------------------
# Check for Mac OS X
#-------------------------------
if [ $(uname -s) == "Darwin" ]; then
    install_osx_software
else
    install_linux_software
fi
#-------------------------------

exit 0
