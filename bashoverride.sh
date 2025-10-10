
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
