### Noetic Compile and Install Long Version

#### Prep Environment

Pick a folder to work in.  That folder should be used whenever SRCPATH is written in the instructions below.

```
cd SRCPATH
wget https://raw.githubusercontent.com/ros/rosdistro/master/rosdep/base.yaml
```
Open the file using favorite editor (vim, emacs, gedit, ...) and modify the `ubuntu` field to include jammy (the Ubuntu 22.04LTS name). If you are new to things, just use gedit:
```
gedit SRCPATH/base.yaml
```
The added line is:
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
For other linux flavors, this may or may not be needed.  Just check them in the list of flavors supported.  Add yours if it is different.

Then, update the ROS package settings to pull from the revised `base.yaml` file.  Edit the file `/etc/ros/rosdep/sources.list.d/20-default.list`. Find the line with `base.yaml` and change it to read:
```
yaml file:///SRCPATH/base.yaml
```

After the above is done, the file should look like the text below:
```
# os-specific listings first
yaml https://raw.githubusercontent.com/ros/rosdistro/master/rosdep/osx-homebrew.yaml osx

# generic
#yaml https://raw.githubusercontent.com/ros/rosdistro/master/rosdep/base.yaml
yaml file:///SRCPATH/base.yaml
yaml https://raw.githubusercontent.com/ros/rosdistro/master/rosdep/python.yaml
yaml https://raw.githubusercontent.com/ros/rosdistro/master/rosdep/ruby.yaml
gbpdistro https://raw.githubusercontent.com/ros/rosdistro/master/releases/fuerte.yaml fuerte

# newer distributions (Groovy, Hydro, ...) must not be listed anymore, they are being fetched from the rosdistro index.yaml instead
```
