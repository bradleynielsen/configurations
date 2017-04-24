#!/bin/bash

echo ''
echo '          _    _  _                    _          '
echo '         | |  | || |                  | |         '
echo '         | |  | || |__   _   _  _ __  | |_  _   _ '
echo '         | |  | || |_ \ | | | || |_ \ | __|| | | |'
echo '         | |__| || |_) || |_| || | | || |_ | |_| |'
echo '          \____/ |_.__/  \__,_||_| |_| \__| \__,_|'
echo '                                                  '
echo '                                                  '
echo '           _____                __  _                            _               '
echo '          / ____|              / _|(_)                          | |              '
echo '         | |      ___   _ __  | |_  _   __ _  _   _  _ __  __ _ | |_  ___   _ __ '
echo '         | |     / _ \ | \_ \ |  _|| | / _  || | | ||  __|/ _ ` || __|/ _ \ | __|'
echo '         | |____| (_) || | | || |  | || (_| || |_| || |  | (_| || |_| (_) || |   '
echo '          \_____|\___/ |_| |_||_|  |_| \__, | \__,_||_|   \__,_| \__|\___/ |_|   '
echo '                                        __/ |                                    '
echo '                                       |___/                                     '
echo ''


#Enable the script by:
#:~$ " chmod +x fastUbuntuConfig.sh "

#####################
#Update Repositories
#####################
echo "==============================="
echo "||  Setting up repositories  ||"
echo "==============================="
echo ""
echo ""

echo "Adding the Spotify repository..."
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886  &> install.log
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list &> install.log

echo "Adding the Unity Tweak Tool repository..."
sudo add-apt-repository -y ppa:freyja-dev/unity-tweak-tool-daily  -y >> install.log

echo "Adding the Atom repository..."
sudo add-apt-repository -y ppa:webupd8team/atom  -y >> install.log

echo "Adding the Variety repository..."
sudo add-apt-repository  ppa:peterlevi/ppa -y >> install.log

echo "Adding the Mongodb repository..."
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 &> install.log
#ubuntu 14.04
echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list &> install.log

echo "Adding the virtualbox repository..."
deb http://download.virtualbox.org/virtualbox/debian trusty contrib-y >> install.log
sudo apt-key add oracle_vbox_2016.asc >> install.log
sudo apt-key add oracle_vbox.asc >> install.log



########
#UPDATE
########
echo "Running update..."
sudo apt-get update -y >> install.log
echo "Updates Complete..."

########
#UPGRADE
########
echo "Running upgrades..."
sudo apt-get upgrade -y >> install.log
echo "Upgrades Complete..."


###########
#Installs
###########
echo "==============================="
echo "||   Install all the things  ||"
echo "==============================="

#gparted
echo "Installing gparted..."
sudo apt-get install gparted -y >> install.log

#chrome
echo "Installing Chrome..."
sudo apt-get install chrome-browser -y >> install.log

#spotify
echo "Installing Spotify..."
sudo apt-get install spotify-client -y >> install.log

#terminator
echo "Installing terminator"
sudo apt-get install terminator  -y >> install.log

#Unity Tweak Tool
echo "Installing Unity Tweak Tool"
sudo apt-get install  unity-tweak-tool -y >> install.log

#Atom
echo "Installing Atom..."
sudo apt-get install atom -y >> install.log

#Variety desktop images
echo "Installing Variety..."
sudo apt-get install variety variety-slideshow -y >> install.log

echo "Installing httpie..."
sudo apt-get install httpie -y >> install.log

echo "Installing mongo..."
sudo apt-get install mongodb-org -y >> install.log

echo "Installing Virtualbox..."
sudo apt-get install virtualbox-5.1  -y >> install.log


###############
#Node installs
###############

#install node, set permissions and globals
echo "======================="
echo "||  Installing Node  ||"
echo "======================="

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -qy nodejs
sudo chown -R $USER /usr/lib/node_modules/


#mongo-hacker
sudo npm i -gy mongo-hacker  &> install.log
#surge webpack budo
sudo npm i -gy react-native-cli  &> install.log
#nodemon
sudo npm i -gy nodemon  &> install.log
#yarn
sudo npm i -gy yarn &> install.log



echo ######################
echo #Configure OS Settings
echo ######################

echo "============================="
echo "||  Configure OS Settings  ||"
echo "============================="

#Set Dash not to search the web
echo "Set Dash not to search the web..."
gsettings set com.canonical.Unity.Lenses remote-content-search 'none'

#move the launcher to the bottom
echo "move launcher to bottom..."
gsettings set com.canonical.Unity.Launcher launcher-position Bottom

#remove useless shit
echo "Removing useless shit..."
sudo apt-get remove -qy unity-webapps-common

#Set time to
echo "Setting up the clock"
gsettings set com.canonical.indicator.datetime custom-time-format '%A %d %B %H:%M:%S'
