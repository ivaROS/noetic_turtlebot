## Turtlebot Install

An attempt was made to make this as simple as possible.  There are two additional rosinstall files that need to be incorporated into the base install that will go into a separate extended workspace.

If all works out, this isntall should be as simple as running a single script from within the SRCPATH:
```
./installTurtlebot.sh
```
If started in proper path and running as expected, then there should be a ton of output, some compiling information being output, then finally 147 packages successfully compiled.  Of those 105 will succeed with warnings.
