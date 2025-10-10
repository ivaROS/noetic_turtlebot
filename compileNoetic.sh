
rosdep update

mkdir src
vcs import --input noetic-sources.rosinstall ./src

#./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release
./src/catkin/bin/catkin_make_isolated --install --install-space /opt/ros/noetic -DCMAKE_BUILD_TYPE=Release


