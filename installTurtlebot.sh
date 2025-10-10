
# Makes an extended workspace under assumption that base workspace is in /opt/ros/noetic
cd /opt/ros
sudo mkdir -p ivalab && sudo chown -R $USER ivalab
cd ivalab
catkin init
catkin config --mkdirs --extend /opt/ros/noetic --cmake-args -DCMAKE_BUILD_TYPE="Release" -DCMAKE_CXX_FLAGS_RELEASE="-O2 -g" -DCMAKE_C_FLAGS_RELEASE="-O2 -g"

wstool init src
wstool merge -t src https://raw.githubusercontent.com/ivaROS/noetic_turtlebot/main/noetic-additional.rosinstall 
wstool merge -t src https://raw.githubusercontent.com/ivaROS/noetic_turtlebot/main/turtlebot.rosinstall 
wstool update -t src -j20

sudo rosdep init
rosdep update
source /opt/ros/noetic/setup.bash
rosdep install --from-paths src --ignore-src -y -r

catkin build

