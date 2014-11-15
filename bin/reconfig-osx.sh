#!/bin/bash

# Prompt for sudo password
sudo -v

echo "    Disabling Dashboard"
defaults write com.apple.dashboard mcx-disabled -boolean YES

echo "    Setting verbose boot mode"
sudo nvram boot-args="-v"

echo "    Disabling trackpad annoyances"
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool false

echo "    Enable full keyboard control for UI components"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo "    Enable password on wake"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "    Set screenshots to PNG"
defaults write com.apple.screencapture type -string "png"

echo "    Configure Finder options"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.finder AppleShowAllFiles FALSE
defaults write com.apple.finder 'ShowPathbar' -bool true

echo "    Set Dock icon size"
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock no-glass -boolean YES

echo "    Configure Terminal.app"
cp ~/Google\ Drive/data/OS\ X/com.apple.Terminal.plist ~/Library/Preferences

echo "    Disable Time Machine"
hash tmutil &> /dev/null && sudo tmutil disablelocal
defaults write com.apple.TimeMachine 'AutoBackup' -bool false

echo "    Configure Alfred"
defaults write com.alfredapp.Alfred clipboard.autopaste -bool false
defaults write com.alfredapp.Alfred clipboard.enabled -bool true
defaults write com.alfredapp.Alfred clipboard.limit -int 4
defaults write com.alfredapp.Alfred clipboard.persist -int 3
defaults write com.alfredapp.Alfred clipboard.snippets.showparent -bool false
defaults write com.alfredapp.Alfred appearance.hideHat -bool true
defaults write com.alfredapp.Alfred appearance.hideStatusBarIcon -bool true
defaults write com.alfredapp.Alfred appearance.rememberQuery -bool true
defaults write com.alfredapp.Alfred appearance.resultCount -int 9
defaults write com.alfredapp.Alfred appearance.smaller -bool true;
defaults write com.alfredapp.Alfred hotKey -int 49
defaults write com.alfredapp.Alfred hotMod -int 1048840
defaults write com.alfredapp.Alfred hotString -string " "
defaults write com.alfredapp.Alfred alfred.sync.folder -string "/Users/scott/Google Drive/data/Alfred"

echo "    Disable volume change notification"
defaults write -g 'com.apple.sound.beep.feedback' -bool false

echo "    Auto-dimming display off"
sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false

echo "    Restarting apps"
killall Finder
killall Dock
killall SystemUIServer
killall Alfred\ 2
killall rcd
open -a Alfred\ 2

echo "Done"
sudo -k
