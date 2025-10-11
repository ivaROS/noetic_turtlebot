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

echo "===== APT CORE PACKAGES done."

# Start with the Gazebo Ignition - Fortress parts before apt package manager gets messed with by adding
# the Noetic ROS sources.  This install has been troublesome.  It looks like ordering is important, as
# well as specifying the minium possible.  What is below should do the trick.
#
sudo wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
sudo apt-get update

sudo apt-get install -y libsdformat12 libsdformat12-dev
sudo apt-get install -y ignition-fortress 

echo "===== GAZEBO - IGNITION FORTRESS package install done."

# Install ROS-relevant libraries that are not bound to older sources and are needed
# for ROS1 to fully compile the {desktop, perception, viz} targets.
#
sudo apt-get install -y python3-opencv libopencv-dev libopencv-core-dev libturbojpeg0-dev
sudo apt-get install -y pyqt5-dev python3-pyqt5 libgtest-dev liblz4-dev liborocos-kdl-dev \
	libbz2-dev libgpgme-dev libyaml-cpp-dev libyaml-dev liblog4cxx-dev
sudo apt-get install -y build-essential python3-empy python3-sip python3-nose

echo "===== ROS1 Library Dependencies and Python Libraries done."
echo "===== ROS1 Specialized packages next." 

# Set package manager to snag ROS stuff from older Ubuntu 20.04LTS sources.
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros-noetic-focal.list'
#curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
sudo apt update

# Get the ROS1 python and building utilities. The PCL part seems to be a mix of 22/jammy and 
# 20/focal version packages.  It bonked out with apt package dependencies from focal.
#
sudo apt-get install python3-rosdep python3-rosinstall-generator python3-vcstools python3-vcstool 
sudo apt-get install python3-catkin-tools python3-wstool python-is-python3 
sudo apt-get install libpcl-ros-dev

echo "===== ROS1 Specialized packages done. running rosdep init, then ready to go." 

# Initialize ROS dependency manager.  Now ready to go with next steps once done.
sudo rosdep init
