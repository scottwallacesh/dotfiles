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
# Ensure Vim plugins are up-to-date, if older than one day
#-------------------------------
find .vim/updated -mtime +0 -exec bash -c "\
    vim +PluginInstall! +PluginClean! +qall
    touch .vim/updated
" \;
#-------------------------------

echo "#-------------------------------"
echo "# END: $(date)"
echo "#-------------------------------"

exit 0
