
rosdep update

# The line below snags all of the generated ROS sources.  It should work.  If not, then
# use rosinstall without the tar flag.  There are some errors, but they might have to do 
# with duplicate entries.  A git (not tar) version of the file exists too. It takes longer
# but seems more reliable.
#
mkdir src
vcs import --input noetic-git-all-but-sim.rosinstall ./src


# Stereo msgs was causing problems.  Added below.  If you don't have issues, leave commented.
# Otherwise uncomment.  Which DIR to uncomment most likely dependson the catkin make command
# options.  
#export NOETIC_SRCPATH=`pwd`
#export stereo_msgs_DIR=$NOETIC_SRCPATH/stereo_msgs/devel_isolated/share/stereo_msgs/cmake
#export stereo_msgs_DIR=$NOETIC_SRCPATH/stereo_msgs/install_isolated/share/stereo_msgs/cmake


export ROS_INSTPATH=/opt/ros/noetic

./src/catkin/bin/catkin_make_isolated --install --install-space $ROS_INSTPATH -DCMAKE_BUILD_TYPE=Release

#./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release
#./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=/usr/bin/python3


