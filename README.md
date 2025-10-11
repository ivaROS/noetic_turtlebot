# Turtlebot on ROS1 Noetic with Ubuntu 22.04

Instructions for installation of ROS1 Noetic, Gazebo Ignition, and Turtlebot interface on Ubuntu 22.04LTS. These instructions operate from the assumption of a fresh Ubuntu installation, or something effectively close to it from a ROS1 perspective.  Given that Noetic is EOL, as is 20.04LTS, it takes a little work to get things going. Insights on how to proceed were obtained from a [medium post for Noetic installation](https://medium.com/@jean.guillaume.durand/installing-ros-noetic-on-ubuntu-22-04-1678e9dab1f5) and [a blog post for Gazebo Ignition installation](https://jeremypedersen.com/posts/2024-07-17-gazebo-ros-install).  The Turtlebot installation instructions were obtained through trial and error when following through on the [R20.04](https://github.com/ivaROS/noetic_turtlebot/releases/tag/R20.04) version of the instructions.  A few changes are needed due to newer compiler versions. The instructions pack together steps for all three of the above as well as reorganizing the source instructions to pack like operations together.  If only a subset is needed, then there will be a few extra steps executed in the earlier parts of the process (mostly in the form of additional `apt` packages downloaded).

There are two versions of things.  The long version and the short version.  The long involves manually entering all of the steps.  The short involves using scripts and files from this repository to shorten the workload.  These are files that were prepared _post-facto_ from going through the process. 

## 1] Prepping the System

### Prep | Short Version
Just clone this repo where you want to install things from and run the `fromscratchNoetic.sh` file.  As a series of steps including the install path creation:
```
mkdir SRCPATH
git clone https://github.com/ivaROS/noetic_turtlebot.git SRCPATH
cd SRCPATH
./fromscratchNoetic.sh
```
Skip to ROS1 Noetic (long or short version).
For this short version, the above command renames the repo when downloading to the terminal substring in SRCPATH.  Make sure that is it something reasonable.  We use 'noesrc' for example with a separate final install path.

### Prep | Long Version 

#### Get Packages
The assumption is that one is working with a near fresh install of Ubuntu 22.04LTS (since that is our typical use case).
```
sudo apt-get install linux-headers-$(uname -r) git
sudo apt-get install pkg-config libyaml-dev  g++ scons  libbullet-dev libsdl1.2-* libsdl-image1.2*
sudo app-get install libspnav0 libspnav-dev bluetooth libbluetooth-devlibcwiid-dev libcwiid1
sudo apt-get install ecl eclib-tools
```
Obtain the `hddtemp` package no longer available in 22.04,
```
cd ~/Downloads
wget http://archive.ubuntu.com/ubuntu/pool/universe/h/hddtemp/hddtemp_0.3-beta15-53_amd64.deb
sudo apt install ~/Downloads/hddtemp_0.3-beta15-53_amd64.deb
```

Now would be an awesome time to install Gazebo Ignition (Fortress) if that's on the agenda.  The step below adds
older package sources and it is best to not to have those sources available.  I've had trouble with Gazebo and 
it may be a sensitivty to ordering. It may be that the current process has resolved those issues as some learning
was done along the way.

Configure ROS sources to permit packages to be snagged from 20.04LTS version
```
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update
```
That should enable installation of unavailable ROS packages related to python and compilation:
```
sudo apt-get install python3-rosdep python3-rosinstall-generator python3-vcstools python3-vcstool build-essential
sudo apt-get install python3-catkin-tools python3-wstool python-is-python3
```

## 2] Installing ROS1 Noetic

There are two versions of this process.  A [long version](Noetic_Long.md) and a [short version](Noetic_Short.md).  The long version has the steps all drafted out per the [medium post](https://medium.com/@jean.guillaume.durand/installing-ros-noetic-on-ubuntu-22-04-1678e9dab1f5).  The short version shortcuts all of that by providing the rosinstall file with edits that pull from the proper places to begin with; no need to delete then snag from git some replacement.  Some manual effort is still needed.

## 3] Installing Gazebo
The short version here just involves invoking the script:
```
./installGazebo.sh
```

### Gazebo | Long Version

Prior to or after compiling ROS, install Gazebo Ignition.
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

## 4] Installing Turtlebot and ROS1-Gazebo Bridge

This portion will download to a different ROS1 workspace, which acts as an extended version of the original Noetic workspace.  It contains a bit more than the original 20.04LTS extended workspace due to missing packages from the ROS1 desktop+perception+viz install from above. As usual there is a long version and a short version (TBD).  See the [Turtlebot instructions](Turtlebot.md).


