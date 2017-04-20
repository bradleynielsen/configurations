#!/bin/bash

echo ''
echo '          _    _  _                    _          '
echo '         | |  | || |                  | |         '
echo '         | |  | || |__   _   _  _ __  | |_  _   _ '
echo '         | |  | || '_ \ | | | || '_ \ | __|| | | |'
echo '         | |__| || |_) || |_| || | | || |_ | |_| |'
echo '          \____/ |_.__/  \__,_||_| |_| \__| \__,_|'
echo '                                                  '
echo '                                                  '
echo '           _____                __  _                            _               '
echo '          / ____|              / _|(_)                          | |              '
echo '         | |      ___   _ __  | |_  _   __ _  _   _  _ __  __ _ | |_  ___   _ __ '
echo '         | |     / _ \ | '_ \ |  _|| | / _` || | | || '__|/ _` || __|/ _ \ | '_d_|'
echo '         | |____| (_) || | | || |  | || (_| || |_| || |  | (_| || |_| (_) || |   '
echo '          \_____|\___/ |_| |_||_|  |_| \__, | \__,_||_|   \__,_| \__|\___/ |_|   '
echo '                                        __/ |                                    '
echo '                                       |___/                                     '
echo ''


#Enable the script by:
#:~$ " chmod +x ubuntuconfig.sh "

#####################
#Update Repositories
#####################
echo "==============================="
echo "||  Setting up repositories  ||"
echo "==============================="
echo ""
echo ""

echo "Adding the Spotify repository..."
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

echo "Adding the Unity Tweak Tool repository..."
sudo add-apt-repository -y ppa:freyja-dev/unity-tweak-tool-daily  -y > install.log

echo "Adding the Atom repository..."
sudo add-apt-repository -y ppa:webupd8team/atom  -y >> install.log

echo "Adding the Variety repository..."
sudo add-apt-repository  ppa:peterlevi/ppa -y >> install.log


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
echo "Installing Variety..."
sudo apt-get install atom -y >> install.log

#Variety desktop images
echo "Installing Variety..."
sudo apt-get install variety variety-slideshow -y >> install.log

echo "Installing httpie..."
sudo apt-get install httpie -y >> install.log


###############
#Node installs
###############

#install node, set permissions and globals
echo "======================="
echo "||  Installing Node  ||"
echo "======================="

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -qy nodejs >> out.log 2 >> err.log
sudo chown -R $USER /usr/lib/node_modules/

#mongo-hacker
sudo npm i -gy mongo-hacker --loglevel silent
#surge webpack budo
sudo npm i -gy react-native-cli --loglevel silent
#nodemon
sudo npm i -gy nodemon --loglevel silent

######################
#Configure OS Settings
######################

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
