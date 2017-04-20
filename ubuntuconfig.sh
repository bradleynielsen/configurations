#!/bin/bash

#Enable the script by:
#:~$ " chmod +x ubuntuconfig.sh "

###########
#Installs
###########
echo "Running update..."
sudo apt-get -qq -qq update
echo "Updates Complete..."
echo "Running upgrades..."
sudo apt-get -qy upgrade
echo "Upgrades Complete..."

#spotify
echo "Spotify install init..."
echo "Adding key..."
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
echo "Running update..."
sudo apt-get -qq -qq update
echo "Updates Complete..."
echo "Installing Spotify..."
sudo apt-get install -qy spotify-client
echo "Spotify install complete"


#terminator
echo "Installing terminator"
sudo apt-get install -y terminator
echo "terminator install complete"

#Unity Tweak Tool
echo "Adding the Unity Tweak Tool repository"
sudo add-apt-repository -y ppa:freyja-dev/unity-tweak-tool-daily
sudo apt-get update -qq
sudo apt-get install -y unity-tweak-tool

#Atom
echo "Adding the Atom repository"
sudo add-apt-repository -y ppa:webupd8team/atom
sudo apt-get update -qq
sudo apt-get install -y atom

#install node, set permissions and globals (also httpie)
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -qy nodejs
sudo chown -R $USER /usr/lib/node_modules/

sudo pip install httpie
npm i -g mongo-hacker
sudo npm i -g react-native-cli #surge webpack budo

####################
#Configure Settings
####################

#Set Dash not to search the web
gsettings set com.canonical.Unity.Lenses remote-content-search 'none'

#move the launcher to the bottom
echo "move launcher to bottom..."
gsettings set com.canonical.Unity.Launcher launcher-position Bottom

#remove useless shit
echo "Removing useless shit..."
sudo apt-get remove -qy unity-webapps-common

#Set the background to read from Variety
echo "Installing Variety..."
echo "Adding the Variety repository"
sudo add-apt-repository  ppa:peterlevi/ppa -y
sudo apt-get update -qq
sudo apt-get install -qy variety variety-slideshow
