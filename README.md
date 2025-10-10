# noetic_turtlebot
Add turtlebot-related packages to a standard noetic installation for Ubuntu 20.04LTS.


Simply run the following command:
```
wget https://raw.githubusercontent.com/ivaROS/noetic_turtlebot/main/install.sh -O /tmp/tbi.sh && bash /tmp/tbi.sh
```

You should make sure that curl has been installed if doing from scratch, otherwise the script may break.

NOTE: Places packages into `/opt/ros/ivalab` and makes that the main ROS source location that then links to noetic (in `/opt/ros/noetic`).
