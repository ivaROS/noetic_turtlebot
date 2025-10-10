# Turtlebot on ROS1 Noetic

Instructions for installation of ROS1 Noetic, Gazebo Ignition, and Turtlebot interface on Ubuntu 22.04LTS.
Given that Noetic is EOL, as is 20.04LTS, it takes a little work to get things going. Insights on how to proceed were obtained from a [medium post for Noetic installation](https://medium.com/@jean.guillaume.durand/installing-ros-noetic-on-ubuntu-22-04-1678e9dab1f5) and [a blog post for Gazebo Ignotion installation](https://jeremypedersen.com/posts/2024-07-17-gazebo-ros-install).  The Turtlebot installation instructions were obtained through trial and error when following through on the [R20.04](https://github.com/ivaROS/noetic_turtlebot/releases/tag/R20.04) version of the instructions.  A few changes are needed due to newer compiler versions.



### Ignore below

Simply run the following command:
```
wget https://raw.githubusercontent.com/ivaROS/noetic_turtlebot/main/install.sh -O /tmp/tbi.sh && bash /tmp/tbi.sh
```

You should make sure that curl has been installed if doing from scratch, otherwise the script may break.

NOTE: Places packages into `/opt/ros/ivalab` and makes that the main ROS source location that then links to noetic (in `/opt/ros/noetic`).
