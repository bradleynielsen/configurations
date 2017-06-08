#spotify
echo "Spotify install init..."
echo "Adding key..."
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
echo "Running update..."
sudo apt-get -qq -qq update
echo "Updates Complete..."
echo "Installing Spotify..."
sudo apt-get install -qy spotify-client
echo "Spotify install complete"
