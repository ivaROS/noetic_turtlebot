sudo apt install python3-catkin-tools python3-wstool python3-rosdep python3-rosinstall python3-rosinstall-generator build-essential libftdi-dev pyqt5-dev-tools ros-noetic-openslam-gmapping ros-noetic-navigation ros-noetic-joy ros-noetic-depthimage-to-laserscan ros-noetic-kobuki-msgs ros-noetic-ecl-threads ros-noetic-ecl-formatters ros-noetic-ecl-streams ros-noetic-ecl-linear-algebra ros-noetic-ecl-geometry ros-noetic-kobuki-dock-drive ros-noetic-kobuki-driver

cd /opt/ros
sudo mkdir catkin_ws && sudo chown -R $USER catkin_ws
cd catkin_ws
catkin init
catkin config --mkdirs --extend /opt/ros/noetic --cmake-args -DCMAKE_BUILD_TYPE="Release" -DCMAKE_CXX_FLAGS_RELEASE="-O2 -g" -DCMAKE_C_FLAGS_RELEASE="-O2 -g"
wstool init src {path to attached rosinstall file} -j20
catkin build
sudo bash -c "echo 'source /opt/ros/catkin_ws/devel/setup.bash' > /etc/profile.d/ros-noetic-turtlebot.sh"
