## Turtlebot Install

An attempt was made to make this as simple as possible.  There are two additional rosinstall files that need to be incorporated into the base install that will go into a separate extended workspace.

### Compiling Library Dependencies

One library needed is Sophus, which is a non-ROS library that is also not part of the standard Ubunti package library.  That means it needs to be downloaded and built separately.  The short/easy version is here and also used in the script.  Skip down lower if that's what you want to use.
The long version has those commands here.

#### Easy Install
```
sudo apt-get install -y ros-noetic-sophus
```

#### Hard Install
Don't even both since the Ubuntu 22.04LTS cmake version is too old.  You'd have to uninstall it, point to KitWare cmake package source and then apt-get the latest one (which should be 3.24 or later).  Or, you could try to adjust the cmake options to revert back.  Go to the `CMakeLists.txt` file and modify the first like to read 3.22 instead of 3.24 and it should work out:

```
sudo apt-get install -y ccache libmetis-dev
mkdir -p lsrc
cd lsrc
git clone https://github.com/strasdat/Sophus
cd Sophus
export SOPHUSPATH=`pwd`
./scripts/install_ubuntu_deps_incl_ceres.sh
cd $SOPHUSPATH
mkdir -p build
cd build
cmake ../
make
sudo make install
```

If using this option, then commenting out the apt line installing `ros-noetic-sophus` as the compile and make install will add it to the system.

### Installation Script

If all works out, this install should be as simple as running a single script from within the SRCPATH:
```
./installTurtlebot.sh
```

If started in proper path and running as expected, then there should be a ton of output, some compiling information being output, then finally 146 packages successfully compiled.  In the last compile attempt, the following lines were output by the process:

> [build] Summary: All 148 packages succeeded!
> [build]   Ignored:   None.                                                                               
> [build]   Warnings:  148 packages succeeded with warnings.
> [build]   Abandoned: None.                                                                               
> [build]   Failed:    None.                                                                               
> [build] Runtime: 1 minute and 44.5 seconds total.                                                        
> [build] Note: Workspace packages have changed, please re-source setup files to use them.

when done with this step and no more ROS1 development will be done, it is probably best to get rid of the apt source for ROS1 Noetic/Focal. _Update:_ The last time run, the output indicated 147 packages (on 10/13/2025).

The output above indicates to re-source the setup file.  For this build in `/opt/ros/ivalab` you'll have to source its setup,
```
source /opt/ros/ivalab/devel/setup.bash
```

#### Install Kobuki Driver

Even though everything compiled, the system is not entirely setup.  The kobuki connection uses an FTDI USB to serial communication device with the kobuki communication software assuming it gets [configured a special way](https://wiki.ros.org/kobuki_ftdi). Basically whatever the kobuki connection device is, the device gets mapped to `/dev/kobuki` for a more consistent API connection point.  To enable that mapping, run:
```
rosrun kobuki_ftdi create_udev_rules
```
Once this has been done, it will be possible to communicate with the Turtlebot.  Then the keyboard teleoperation test below for the Turlteobt 2 base will work.

#### Test Build

The first test assumes that the Gazebo install process was also included, as the Turtlebot install included a Husky simulation repository structly for testing purposes.  In one terminal:
```
source /opt/ros/ivalab/devel/setup.bash
roslaunch semantic_segmentation_husy seg_husky.launch
```
and in a second:
```
source /opt/ros/ivalab/devel/setup.bash
rosrun semantic_segmentation_husky husky_teleop
```
Teleoperate the husky and see it move awkwardly.  By awkwardly, it rotates about the rear axle rather than around the center of mass.

A second test assumes that the computer in question can be attached to an actual turtlebot.  Again, in two separate terminals:
```
source /opt/ros/ivalab/devel/setup.bash
roslaunch turtlebot_bringup minimal.launch
```
and
```
source /opt/ros/ivalab/devel/setup.bash
roslaunch turtlebot_teleop keyboard_teleop.launch
```
The above is done from memory and might be off.  Will correct once able to connect to the actual robot base.

## Warnings to Eventually Address

_EIGEN vs EIGEN3 Warning:_ <BR>
A lot of the code uses the EIGEN package specification.  Warnings are spit out that the find directive should search for EIGEN3.  Those cmake specifications should be adjusted eventually. Adjustments may be non-trivial as Eigen3 has a different cmake configuration (see below).

_More Eigen3 Problems:_ <BR>
Some elements of the cmake package settings for Eigen3 have been removed, which means that using expected variables and conditionals in the CMakeLists file will actually not work.  It just has to be removed.  For `ecl_eigen` package, that was done, which means that everything should compile with the system Eigen3 version.  See the patch for `ecl_eigen`, which strips the old stuff out.  The current setup works, but adding new packages may cause these kinds of errors (for example EIGEN3_FOUND is no longer valid).

