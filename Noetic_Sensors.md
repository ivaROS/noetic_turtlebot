# ROS1 Neotic Commonly Used Sensors


These instructions describe what's needed to prep the ROS1 install codebase associated to
the `noetic-sensors.rosinstall` file.  Some sensors require additional libraries or SDKs
to first be installed and available.

## Kinect with OpenNI

This first version of the library requires [drivers to be installed](https://wiki.ros.org/openni_camera).
In particular the OpenNI driver and the SensorKinect package (requires [OpenNI unstable version](https://github.com/avin2/SensorKinect/blob/unstable/README)).

What is on the ROS wiki seems to differ from the [PrimeSense/Sensor repo](https://github.com/PrimeSense/Sensor) 
that [SensorKinect](https://github.com/avin2/SensorKinect/tree/unstable) is forked from.  
What's the proper one to install?  Does it matter for Noetic?  The core code has not changed in over a decade.

## Intel RealSense

The Intel RealSense SDK should be installed (verson 2.0). Unsure if the apt
packages will work or if compilation is needed.

## HESAI Lidars

Mayt require first installing the [HESAI LIDAR Generak SDK](https://github.com/HesaiTechnology/HesaiLidar_General_SDK).


## Velodyne LIDARS

Appears to be stand-alone and not require any installed drivers/SDKs.


