
# Get current path, which is presumably where this script being invoked from.
OWD=`pwd`

# First get and install the Sophus library.  We are putting it into a local source
# directory called `lsrc` and then installing it to /usr/local/ as the sensible option.
#
#sudo apt-get install -y ccache libmetis-dev
#mkdir -p lsrc
#cd lsrc
#git clone https://github.com/strasdat/Sophus
#cd Sophus
#export SOPHUSPATH=`pwd`
#./scripts/install_ubuntu_deps_incl_ceres.sh
#cd $SOPHUSPATH
#mkdir -p build
# cd build
# cmake ../
# make 
# sudo make install
#
# REQUIRES NEWER VERSION OF CMAKE THAN Ubuntu 22.04 PROVIDES.  GOING WITH APT PACKAGE
# FROM NOETIC/FOCAL APT DATABASE.
# IF YOU REALLY WANT TO COMPILE FROM SOURCE, THEN ADJUST FIRST LINE OF CMakeLists.txt
# TO BE 3.22 AND NOT 3.24.  IT APPEARS TO WORK JUST FINE.
# THE ABOVE LINES OF CODE TAKE A WHILE.

#sudo apt-get install ros-noetic-sophus

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

export IVAPATH=`pwd`

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

patch src/ecl_core/ecl_eigen/CMakeLists.txt < $OWD/patches/ecl_eigen.patch

export HPATH="$IVAPATH/src/gazebo-ignition-ros/semantic_segmentation_husky/sdf"
export NEWHUSKY="$HPATH/husky.sdf"
sed -i "s|husky\.sdf|$NEWHUSKY|g" $HPATH/world.sdf

catkin build

