## Additional Drivers and Packages for Autonomous IVALab Robots

The core ROS1 installation is missing lots of stuff.


### URG Drivers for Hokuyo

Requires `urg_c` and `urg_node` from ROS drivers git.

### Kinect Drivers for Xbox360

The easiest and simplest is to use the libfreenect drivers, which won't provide skeleton information.
The OpenNI and OpenNI2 drivers turned out to be a bit iffy.  OpenNI2 ROS1 compile errors out.  
Did not try OpenNI1 ROS1.

The negative impact is that skeleton tracking would not be available, as that
involves the NITE/NITE2 libraries usually co-installed with OpenNI/OpenNI2.


