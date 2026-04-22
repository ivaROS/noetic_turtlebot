#!/usr/bin/bash
#
# All of the necessary dependencies have been pre-obtained in rosinstall files
# located within this repository.  Before the rosinstall file was downloaded
# from the ROS main source location, but since some changes are needed, we
# eventually just kept a copy here.  Since ROS1 Noetic is EOL, there should be
# no further changes to those sources and keeping a copy here should not be
# detrimental.
#

# First specify working directories for things.  Where are the Noetic source
# files.  Where should ROS1 Noetic be installed.  The sudo user group.
# The group specification uses default Debian/linux group setting.  
# Modify if different.
#
export CWD=`pwd`
export NOETIC_SRCPATH=$CWD
export ROS_INSTPATH=/opt/ros/noetic

export MYGROUP=$USER

# Run ROS update as indicated to do by previous script.
rosdep update

# The line below snags all of the generated ROS sources.  It should work.  If not, then
# use rosinstall without the tar flag.  There are some errors, but they might have to do 
# with duplicate entries.  A git (not tar) version of the file exists too. It takes longer
# but seems more reliable.
#
# Update: the git version is default now, not the tar version.
#
mkdir -p src
vcs import --input noetic-git-all-but-sim.rosinstall ./src

# Stereo msgs was causing problems.  Added below.  If you don't have issues, leave commented.
# Otherwise uncomment.  Which DIR to uncomment most likely dependson the catkin make command
# options.  
#export NOETIC_SRCPATH=`pwd`
#export stereo_msgs_DIR=$NOETIC_SRCPATH/stereo_msgs/devel_isolated/share/stereo_msgs/cmake
#export stereo_msgs_DIR=$NOETIC_SRCPATH/stereo_msgs/install_isolated/share/stereo_msgs/cmake


# Create the location to install ROS1 Noetic and make sure to adjust ownership
# so that installation may proceed.  Using sudo means that root is the owner and group.
# Only root would be able to install and work in the ROS1 Noetic directory space.
# Adjust directory to be owned by self 
#
sudo mkdir -p $ROS_INSTPATH
sudo chown $USER:$MYGROUP -R $ROS_INSTPATH

./src/catkin/bin/catkin_make_isolated --install --install-space $ROS_INSTPATH -DCMAKE_BUILD_TYPE=Release

export stereo_msgs_DIR=$NOETIC_SRCPATH/devel_isolated/share/stereo_msgs/cmake

# OTHER APPROACHES TAKEN.  ABOVE LINE IS WHAT WORKED AND PREFERRED.
# FOR DEBUG OR OTHER INSTALL TYPES, ADJUST AND RUN AS FITTING.
# PROBABLY IT IS BEST TO DO MANUALLY.
#
#./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release
#./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=/usr/bin/python3
