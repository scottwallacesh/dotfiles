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
        echo "Sorry, I don't know how to install software on this machine yet."
        exit 1
    fi
    #-------------------------------

    xargs sudo ${INSTALLCMD} <<-EOF
        ack
        git
        htop
        mosh
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
        git
        coreutils
        htop-osx
        mosh
        python3
        vim
        homebrew/dupes/openssh
	EOF
    #-------------------------------

    #-------------------------------
    # Install Casks
    #-------------------------------
    xargs brew cask install <<-EOF
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
    # Some tools require root set-UID
    #-------------------------------
    xargs -n1 -I % bash -c 'find $(dirname $(greadlink -f $(which %))) -name $(basename $(which %)) -type f ! \( -perm -u+s -a -user root \) ' <<-EOF | xargs -n 1 -I % sudo bash -c 'chown root: % && chmod u+s %'
        htop
	EOF
    #-------------------------------

    #-------------------------------
    # Clean up
    #-------------------------------
    brew cask cleanup
    brew cleanup
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
