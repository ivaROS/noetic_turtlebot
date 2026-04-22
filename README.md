# Turtlebot on ROS1 Noetic with Ubuntu 22.04

Provides a series of scripts thaat will install ROS1 Noetic, Gazebo Ignition, and Turtlebot interfaces on Ubuntu 22.04LTS. These instructions operate from the assumption of a fresh Ubuntu installation, or something effectively close to it from a ROS1 perspective. If desired, ROS2 can be installed afterwards without problems.  If ROS2 has been installed prior to attempting a ROS1 install, then problems may result due to installed packages having conflicting dependencies. The sensitivity arises from the fact that Noetic is EOL, as it was for Ubuntu 20.04LTS. It took some trial-and-error to get things going.

The earlier repos had more detailed instructions but it become more and more difficult to maintain currency of the instructions as errors were fixed and the process evolved.  Now, the scripts are documented and serve as instructions if one would rather go line-by-line, or chunk-by-chunk. 
Insights on how to proceed were obtained from a [medium post for Noetic installation](https://medium.com/@jean.guillaume.durand/installing-ros-noetic-on-ubuntu-22-04-1678e9dab1f5) and [a blog post for Gazebo Ignition installation](https://jeremypedersen.com/posts/2024-07-17-gazebo-ros-install).  The Turtlebot installation instructions were obtained through trial and error when following through on the [R20.04](https://github.com/ivaROS/noetic_turtlebot/releases/tag/R20.04) version of the instructions.  A few changes are needed due to newer compiler versions. 

## Process

The entire process is a series of script to run.  I tend to clone into `noesrc` first (short for Noetic source),

> git clone https://github.com/ivaROS/noetic_turtlebot.git noesrc

Then go into the directory of the cloned repository.  The process proceeds from there under the assumption that the user executing everything has `sudo` privileges. Again, there is explanation of the process in the scripts just in case something goes wrong.

In order, they are:

1. `fromscratchNoetic.sh`
2. `compileNoetic.sh`
3. `installTurtlebot.sh`

The last part is optional and specific to our robots.

### Compiling Noetic.

When the compile finishes, the last line of output sould be something like:

    <== Finished processing package [211 of 211]: 'xacro'

Once done, you've got a basic version of Noetic working. Of course, even this version is missing quite a bit. The missing parts should be added as needed. For us, that includes things like the Turtlebot/Kobuki ROS1 code and `move_base`.  The next script helps take care of those missing elements, if desired.  It is customized to our group's needs.   You can always create a similar version with custom script for your needs.

### Compiling Turtlebot

If started in proper path and running as expected, then there should be a ton of output, some compiling information being output, then finally 146 packages successfully compiled.  In the last compile attempt, the following lines were output by the process:

> [build] Summary: All 148 packages succeeded!
> [build]   Ignored:   None.                                                                               
> [build]   Warnings:  148 packages succeeded with warnings.
> [build]   Abandoned: None.                                                                               
> [build]   Failed:    None.                                                                               
> [build] Runtime: 1 minute and 44.5 seconds total.                                                        
> [build] Note: Workspace packages have changed, please re-source setup files to use them.

when done with this step and no more ROS1 development will be done, it is probably best to get rid of the apt source for ROS1 Noetic/Focal. 

Please checkout the [Turtlebot instructions](Turtlebot.md) for any additional steps.  Some of the instructions there are already in the script.  Look more to the end (like kobuki dev rules).


_Update 10/13/2025:_ Output indicated 147 packages. <BR>
_Update 04/22/2026:_ Output indicated 139 packages. 
