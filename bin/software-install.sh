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
        p7zip
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

    # Update Brew formulae if older than 24 hours
    find /usr/local/.git -name FETCH_HEAD -mtime +0 -exec brew update \;

    # Install homebrew/bundle tap if we don't have it
    [ -d /usr/local/Library/Taps/homebrew/homebrew-bundle ] || brew tap homebrew/bundle

    #-------------------------------
    # Run brew bundle if there's a newer version of Brewfile
    #-------------------------------
    if [ ~/Brewfile -nt ~/.Brewfile.updated ]; then
        brew bundle && touch ~/.Brewfile.updated
    fi
    #-------------------------------

    #-------------------------------
    # Upgrade and clean
    #-------------------------------
    brew upgrade
    brew cleanup
    brew bundle check || ( cask-upgrade auto && cask-tidy )
    brew cask cleanup
    #-------------------------------
}

function __remove-cask {
    caskBasePath="/opt/homebrew-cask/Caskroom"
    local cask="$1"
    local caskDirectory="$caskBasePath/$cask"
    local versionsToRemove="$(ls -r $caskDirectory | sed 1,1d)"
    if [[ -n $versionsToRemove ]]; then
        while read versionToRemove ; do
            echo "Removing $cask $versionToRemove..."
            rm -rf "$caskDirectory/$versionToRemove"
        done <<< "$versionsToRemove"
    fi
}

function cask-tidy {
    while read cask; do
        __remove-cask "$cask"
    done <<< "$(brew cask list)"
}

echo "#-------------------------------"
echo "# START: $(date)"
echo "#-------------------------------"

#-------------------------------
# Check for Mac OS X
#-------------------------------
if [ $(uname -s) == "Darwin" ]; then
    install_osx_software
else
    install_linux_software
fi
#-------------------------------

#-------------------------------
# Ensure Vim plugins are up-to-date
#-------------------------------
vim +PluginInstall! +PluginClean! +qall
#-------------------------------

echo "#-------------------------------"
echo "# END: $(date)"
echo "#-------------------------------"

exit 0
