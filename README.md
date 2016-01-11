# Experimental Platform

Experimental Platform is a platform for local application development. It enables developers to `git push` source code to a local machine where it is executed automatically.

As we're in the initial stages of the development we currently deliver a Vagrant based test environment. Please feel free to try it out. Feedback is always welcome!

## Install on existing hardware

### Requirements

* x86 based hardware
* [CoreOS Linux](https://coreos.com/os/docs/latest/installing-to-disk.html), preferably the beta channel
* at least 2 GByte of free RAM
* roughly 5 GByte of free HD space


### Install

    $ curl https://raw.githubusercontent.com/experimental-platform/platform-configure-script/master/platform-configure.sh | sudo CHANNEL=alpha PLATFORM_SYS_GROUP=protonet PLATFORM_INSTALL_OSUPDATE=true PLATFORM_INSTALL_REBOOT=true sh


## Install in local VM

Overview (details follow below):

1. Install [Vagrant](https://www.vagrantup.com/downloads.html) and [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
2. Clone this repository and create the VM
3. Install `experimental-platform`

### Requirements

* at least 2 GByte of free RAM
* roughly 5 GByte of free HD space
* CoreOS beta channel


### Step 1: Install Vagrant and VirtualBox

Vagrant is a VM manager widely used to create ad-hoc environments for testing. If you are not familiar with it please consult the documentation found on the following websites:

* [Virtualbox](https://www.virtualbox.org)
* [Vagrant](https://www.vagrantup.com)


### Step 2: Start the VM

Platform installation is based on a running CoreOS instance. To simplify local testing we include a primitive `Vagrantfile` that should get you running in a few minutes.

    $ git clone https://github.com/experimental-platform/platform-configure-script.git
    $ cd platform-configure-script
    $ vagrant up

### Step 3: Install experimental platform

    $ vagrant ssh -c "curl https://raw.githubusercontent.com/experimental-platform/platform-configure-script/master/platform-configure.sh | sudo CHANNEL=alpha PLATFORM_SYS_GROUP=protonet PLATFORM_INSTALL_OSUPDATE=true PLATFORM_INSTALL_REBOOT=true sh"

This step will install the software and then reboot the system. Depending on the network configuration it might not come up on its own, in that case please start it manually with `vagrant up`. A few moments later the experimental platform web interface should be available under [http://paleale.local](http://paleale.local).
