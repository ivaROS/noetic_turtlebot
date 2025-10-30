
rosdep update

# The line below snags all of the generated ROS sources.  It should work.  If not, then
# use rosinstall without the tar flag.  There are some errors, but they might have to do 
# with duplicate entries.  A git (not tar) version of the file exists too. It takes longer
# but seems more reliable.
#
mkdir src
vcs import --input noetic-git-all-but-sim.rosinstall ./src

export NOETIC_SRCPATH=/opt/ros/noesrc
export stereo_msgs_DIR=$NOETIC_SRCPATH/devel_isolated/share/stereo_msgs/cmake

#./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release
./src/catkin/bin/catkin_make_isolated --install --install-space /opt/ros/noetic -DCMAKE_BUILD_TYPE=Release
#./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=/usr/bin/python3


