# Prepping to install ROS1 Noetic on a fresh Ubuntu 22.04LTS install 
#

# Get core files needed from standard sources.
sudo apt-get install -y linux-headers-$(uname -r) git lsb-release wget gnupg
sudo apt-get install -y pkg-config libyaml-dev  g++ scons  libbullet-dev libsdl1.2-* libsdl-image1.2*
sudo app-get install -y libspnav0 libspnav-dev bluetooth libbluetooth-devlibcwiid-dev libcwiid1
sudo apt-get install -y ecl eclib-tools

# Get hddtemp from older source.
cd ~/Downloads
wget http://archive.ubuntu.com/ubuntu/pool/universe/h/hddtemp/hddtemp_0.3-beta15-53_amd64.deb
sudo apt install ~/Downloads/hddtemp_0.3-beta15-53_amd64.deb

# Set package manager to snag ROS stuff from older Ubuntu 20.04LTS sources.
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update

# Get the ROS1 python and building utilities.
sudo apt-get install python3-rosdep python3-rosinstall-generator python3-vcstools python3-vcstool build-essential
sudo apt-get install python3-catkin-tools python3-wstool python-is-python3

# Now for Gazebo parts.
sudo wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
sudo apt-get update

sudo apt-get install -y ignition-fortress libignition-gazebo6-6 libignition-gazebo-dev libignition-gazebo-plugins


# Initialize ROS dependency manager.  Now ready to go with next steps once done.
sudo rosdep init
