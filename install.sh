sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt install curl -y
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update
sudo apt install -y ros-noetic-desktop-full \
python3-catkin-tools python3-wstool python3-rosdep python3-rosinstall python3-rosinstall-generator python-is-python3

cd /opt/ros
sudo mkdir -p ivalab && sudo chown -R $USER ivalab
cd ivalab
catkin init
catkin config --mkdirs --extend /opt/ros/noetic --cmake-args -DCMAKE_BUILD_TYPE="Release" -DCMAKE_CXX_FLAGS_RELEASE="-O2 -g" -DCMAKE_C_FLAGS_RELEASE="-O2 -g"
wstool init src
wstool merge -t src https://raw.githubusercontent.com/ivaROS/noetic_turtlebot/main/rosinstall 
wstool update -t src -j20

sudo rosdep init
rosdep update
source /opt/ros/noetic/setup.bash
rosdep install --from-paths src --ignore-src -y -r

catkin build

BASH_FILE="/etc/bash.bashrc"

function add_to_bashrc {
    #echo "$#"
	if (($# == 1)); then
	    local COMMAND="$1"
	else
	    local COMMAND="$2"
	fi
	
	if ! grep -Fq "$1" "$BASH_FILE"; then
	    sudo bash -c "echo $COMMAND >> $BASH_FILE"
		echo "Added '$COMMAND' to $BASH_FILE"
	else
		echo "$BASH_FILE already contains '$COMMAND'"
	fi
}

add_to_bashrc "source /opt/ros/ivalab/devel/setup.bash"
add_to_bashrc "export TURTLEBOT_3D_SENSOR" "export TURTLEBOT_3D_SENSOR=kinect"
