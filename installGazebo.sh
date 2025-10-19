# Gazebo Ignition - Fortress 
# This install has been troublesome.  It looks like ordering is important, as
# well as specifying the minium possible.  What is below should do the trick.
#

sudo apt-get update
sudo apt-get install -y lsb-release wget gnupg
sudo wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
sudo apt-get update

sudo apt-get install -y libsdformat12 libsdformat12-dev
sudo apt-get install -y ignition-fortress 
