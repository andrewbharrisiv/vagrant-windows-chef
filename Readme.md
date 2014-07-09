# Vagrant Configuration for Windows Box #
This is the configuration repository for windows boxes used by Drake Cooper.
Most information on vagrant can be found at the website vagrantup.com. The
specifics of windows configuration in the repository are detailed below.

## Virtualbox Options ##
----
The vagrant virutalbox provider includes a number of options for configuring
the performance characteristics of the virtual machine that vagrant creates.
Since the windows operating system requires more memory and cpu than the
typical linux system, the memory allocated should be 2048 at minimum. Other
option here include launching the virutal machine with the gui.

## Shared Folders ##
----
In order to properly host an IIS website without serious errors, the website
folder must be shared with a protocol other than the default virtualbox
protocol. In this case, rsync is used and should maintain an auto update of
the syncronized folder on the vagrant box.

## Shell Provisioner ##
----
The shell provisioner for the vagrant box is primarily responsible for
ensuring that the appropriate software is installed for the chef
provisioner to opererate propperly. Each script is commented and named
in a straight forward way such that it should be easy to understand and
modify as needed.

## Chef Solo Provisioner ##
----
The chef solo provisioner is responsible for the system specific configuration
needed by the current vagrant box. This is where the possible IIS, PHP,
Node.js, Ruby, or any other system specific configuration is done. This will
require knowledge of the chef automation system and language. Details can be
found at http://www.getchef.com/.