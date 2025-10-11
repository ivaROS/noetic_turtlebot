## Noetic Compile and Install Long Version

### Prep Environment
Initialize the ROS dependency manager:
```
sudo rosdep init
```

Pick a folder to work in.  That folder should be used whenever SRCPATH is written in the instructions below. The same path will be used to contain the Noetic installation source and serve as a ROS1 workspace.  Keep that in mind when naming it.

```
cd SRCPATH
wget https://raw.githubusercontent.com/ros/rosdistro/master/rosdep/base.yaml
```
Open the file using favorite editor (vim, emacs, gedit, ...) and modify the `ubuntu` field of the `hddtemp` specification to include jammy (the Ubuntu 22.04LTS name). If you are new to things, just use gedit:
```
gedit SRCPATH/base.yaml
```
Search for the line starting with `hddtemp:` then edit its sub-parameters by appending the line below:
```
    jammy: [hddtemp]
```
so that the `ubuntu` field reads
```
 ubuntu:
    '*': null
    bionic: [hddtemp]
    focal: [hddtemp]
    impish: [hddtemp]
    jammy: [hddtemp]
```
or something to that effect (the impish line might be missing; that's OK).
For other linux flavors, this may or may not be needed.  Just check them in the list of flavors supported.  Add yours if it is different.

Then, update the ROS package settings to pull from the revised `base.yaml` file.  Edit the file `/etc/ros/rosdep/sources.list.d/20-default.list`. Find the line with `base.yaml` and change it to read:
```
yaml file://SRCPATH/base.yaml
```
where SRCPATH should include the leading `/` such that there are three of them in a row.
After the above is done, the file should look like the text below:
```
# os-specific listings first
yaml https://raw.githubusercontent.com/ros/rosdistro/master/rosdep/osx-homebrew.yaml osx

# generic
#yaml https://raw.githubusercontent.com/ros/rosdistro/master/rosdep/base.yaml
yaml file://SRCPATH/base.yaml
yaml https://raw.githubusercontent.com/ros/rosdistro/master/rosdep/python.yaml
yaml https://raw.githubusercontent.com/ros/rosdistro/master/rosdep/ruby.yaml
gbpdistro https://raw.githubusercontent.com/ros/rosdistro/master/releases/fuerte.yaml fuerte

# newer distributions (Groovy, Hydro, ...) must not be listed anymore, they are being fetched from the rosdistro index.yaml instead
```
Update the ROS dependency manager:
```
rosdep update
```

### Prep ROS1 Install Code

Get the ROS install dependency list for the `desktop` compile target and augment it with the `perception` and `viz` targets by appending them to the `desktop` list. Everything will be pulled into the SRCPATH by first navigating there:
```
cd SRCPATH
rosinstall_generator --rosdistro noetic --deps --tar desktop perception viz > noetic-desktop.rosinstall
mkdir ./src
```

The ROS install sources for a few packages need to be revised.  The revisions will be for `rosconsole` and `urdf`.  Again, using favorite editor, find the `rosconsole` and `urdf` lines, then update them.
```
- git:
    local-name: rosconsole
    uri: https://github.com/dreuter/rosconsole.git
    version: noetic-jammy
```
and
```
- git:
    local-name: urdf
    uri: https://github.com/dreuter/urdf.git
    version: set-cxx-version
```
Due to the appending process, there will be duplicates of ``rosconsole`` and ``urdf``. Find and delete those lines. Also delete the one associated to `urdf_parser_plugin` since the above `urdf` repository contains it too.

Execute:
```
vcs import --input noetic-desktop.rosinstall ./src
```
and everything should be properly downloaded from specified source locations.  

### Actual Compile
Compile
```
cd SRCPATH
./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release
```
To install in the default location `/opt/ros/noetic`, then modify
```
./src/catkin/bin/catkin_make_isolated --install --install-space /opt/ros/noetic -DCMAKE_BUILD_TYPE=Release
```
The last line of outptu sould be something like:
> <== Finished processing package [211 of 211]: 'xacro'

Once done, you've got a basic version of Noetic working.  Of course, even this version is missing quite a bit.  The missing parts should be added as needed.  For us, that includes things like the Turtlebot/Kobuki ROS1 code and `move_base`.

## Problems and Nasty Fixes

_vcs import fails to download:_ <BR>
Sometimes, the import line bonks out because some packages do not download from their git source.  In those cases, removing the `--tar` flag helps as they are successfully pulled from the source repository.  The compile script explains how to shift the source files from being tar files to being the actual git repo.  For the short version, there is already a rosinstall file (small name change).  For the long version, the instructions should be there.

_stereo_msgsConfig.cmake missing:_ <BR>
For some funny reason the `image_view` package cannot find the `stereo_msgs` package that should have been built earlier on in the process.  That leads the compilation to stop and complain.  There are two solutions.  One is to provide a compiler directive flag to the catkin make command
```
-Dstereo_msgs_DIR=SRCPATH/install_isolated/share/stereo_msgs/cmake
```
which applies to ALL packages and will give warnings for every package compiled, except for the `image_view` one or any other later package relying on `stereo_msgs`.  Another is to go to the CMakeLists.txt file of each of those packages relying on `stereo_msgs` and adding the missing variable directly for the CMakeLists.  Right before the first `find_package` line add a set directive:
```
set(stereo_msgs_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../../../install_isolated/share/stereo_msgs/cmake)
```
The above uses relative paths for the make isolated catkin build so that it is less dependent on where you've put things. For example, in the case of the `image_view` package, the file can be found in `SRCPATH/src/image_pipeline/image_view/CmakeLists.txt`. A different compilation scheme or set of flags may require a different intervention.  The approach is to find the `stereo_msgsConfig.cmake` file that got built then inform the `image_view/CMakeLists.txt` file about the path. Not pretty, but functional.


