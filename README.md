# Turtlebot on ROS1 Noetic

Instructions for installation of ROS1 Noetic, Gazebo Ignition, and Turtlebot interface on Ubuntu 22.04LTS.
Given that Noetic is EOL, as is 20.04LTS, it takes a little work to get things going. Insights on how to proceed were obtained from a [medium post for Noetic installation](https://medium.com/@jean.guillaume.durand/installing-ros-noetic-on-ubuntu-22-04-1678e9dab1f5) and [a blog post for Gazebo Ignotion installation](https://jeremypedersen.com/posts/2024-07-17-gazebo-ros-install).  The Turtlebot installation instructions were obtained through trial and error when following through on the [R20.04](https://github.com/ivaROS/noetic_turtlebot/releases/tag/R20.04) version of the instructions.  A few changes are needed due to newer compiler versions. The instructions pack together steps for all three of the above.  If only a subset is needed, then there will be a few extra steps (mostly in the form of additional `apt` packages downloaded).

### Get Packages
The assumption is that one is working with a near fresh install of Ubuntu 22.04LTS (since that is our typical use case).
```
sudo apt-get install python3-rosdep python3-rosinstall-generator python3-vcstools python3-vcstool build-essential
sudo apt-get install linux-headers-$(uname -r) git
sudo apt-get install python3-catkin-tools python3-wstool python3-rosdep python3-rosinstall python3-rosinstall-generator python-is-python3
sudo apt-get install pkg-config libyaml-dev  g++ scons  libbullet-dev libsdl1.2-* libsdl-image1.2*
sudo app-get install libspnav0 libspnav-dev bluetooth libbluetooth-devlibcwiid-dev libcwiid1
sudo apt-get install ecl eclib-tools
```

### Gazebo
Prior to or after compiling ROS, install Gazebo Ignition based on [this how-to](https://jeremypedersen.com/posts/2024-07-17-gazebo-ros-install), which consists of executing the following:
```
sudo apt-get update
sudo apt-get install -y lsb-release wget gnupg
sudo wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
sudo apt-get update
```
Once done, time to get Gazebo Ignition:
```
sudo apt-get install  ignition-fortress libignition-gazebo6-6 libignition-gazebo-dev libignition-gazebo-plugins
```
It should work no problems.  Now you’ve got the foundations needed to complete ROS and ROS-Gazebo-Bridge installation.  It won’t be enough for the Turtlebot, but will be a good start.

### Turtlebot and ROS1-Gazebo Bridge Installation

TBD.

### Ignore below

Simply run the following command:
```
wget https://raw.githubusercontent.com/ivaROS/noetic_turtlebot/main/install.sh -O /tmp/tbi.sh && bash /tmp/tbi.sh
```

You should make sure that curl has been installed if doing from scratch, otherwise the script may break.

NOTE: Places packages into `/opt/ros/ivalab` and makes that the main ROS source location that then links to noetic (in `/opt/ros/noetic`).
