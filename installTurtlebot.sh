
# Get current path, which is presumably where this script being invoked from.
OWD=`pwd`

# Makes an extended workspace under assumption that base workspace is in /opt/ros/noetic
# Adjust NOETICPATH if it is elsewhere.  It will then make the extended workspace in 
# /opt/ros/ivalab
NOETICPATH=/opt/ros/noetic

cd /opt/ros
sudo mkdir -p ivalab && sudo chown -R $USER ivalab
cd ivalab
catkin init
catkin config --mkdirs --extend $NOETICPATH --cmake-args -DCMAKE_BUILD_TYPE="Release" \
		-DCMAKE_CXX_FLAGS_RELEASE="-O2 -g" -DCMAKE_C_FLAGS_RELEASE="-O2 -g"

wstool init src
wstool merge -t src https://raw.githubusercontent.com/ivaROS/noetic_turtlebot/main/noetic-additional.rosinstall 
wstool merge -t src https://raw.githubusercontent.com/ivaROS/noetic_turtlebot/main/turtlebot.rosinstall 
wstool update -t src -j20

# The patches below adjust the CMakeLists.txt file to have the default build as Fortress.
# For some funny reason the Fortress CMAKE definitions are missing, and the default build
# is some super old version of Gazebo (v4 Ignition maybe).  That causes all sorts of
# problems.  The quick/nasty fix was to just override the default to be Igntion Fortress.
#
patch src/ros_gz/ros_ign_gazebo/CMakeLists.txt < $OWD/patches/ros_ign_gazebo.patch
patch src/ros_gz/ros_ign_bridge/CMakeLists.txt < $OWD/patches/ros_ign_bridge.patch
patch src/ros_gz/ros_ign_image/CMakeLists.txt < $OWD/patches/ros_ign_image.patch

rm -Rf src/kobuki_ros/kobuki_desktop/kobuki_gazebo*
# Have not yet fixed this.  Deleting until fixed.

# Line below already run as part of ROS1 install.  Commenting out. It complains when run again.
# sudo rosdep init
rosdep update
source /opt/ros/noetic/setup.bash
rosdep install --from-paths src --ignore-src -y -r

catkin build

