**!! This is just the README repository for the project - the actual repositories are all linked below !!**

![Experimental Platform](http://experimental-platform.github.io/img/static-logo.png)

For us, working on sensor and IoT projects always meant spending hours on end trying to fiddle around with environments, obscure device APIs and figuring out how to access them remotely with languages and frameworks we didn't know.

So we decided to build an open development platform that makes the whole experience fun. It uses standard technologies like CoreOS and Docker and runs on your local machine.

Experimental Platform is a platform for local application development. It enables developers to `git push` source code to a local machine where it is executed automatically.

![Co2 to Hue Example](http://experimental-platform.github.io/img/co2demo.gif)
*This is an example from the example application we use at http://experimental-platform.github.io*

Please head over to http://experimental-platform.github.io to see some more examples and feel free to try it out, contribute and give feedback!

## Features we are working on

### Device Discovery

Working on IoT projects shouldn't mean spending hours trying to find your devices, getting them to connect and figure out their APIs. EP comes with a simple device discovery mechanism that is both simple to use and simple to expand.

### Firmware Directory

That CO2 sensor you always wanted to build and hook up to your wireless network? Somebody already built that! By building up a directory of firmwares and an easy way to flash your devices we'll be able to build upon each others work. That's what it's all about isn't it?

Platform will also provide a toolchain to flash your devices with a fully configured firmware directly from the platform itself.

### Services

That cool app that you just pushed to the experimental platform now needs a simple messaging layer? What if you could simply add a service to provide that? Just like on Heroku, EP provides a simple way to include services and use them in your application.

### REST API

A standard for the internet-of-things (IoT)? It's already here: REST. So no need to reinvent the weel. Experimental Platform aims to provide an easy way to access all of a smart devices capability. Wether it's reading sensors or actuating actuators.

### First things first

In the first phase, we're aiming to build an IoT environment that's easy to use, fun and reliable. Help us make this happen!

## Install on existing hardware

### Requirements

* x86 based hardware
* [CoreOS Linux](https://coreos.com/os/docs/latest/installing-to-disk.html), preferably the stable channel
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
* CoreOS stable channel


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

This step will install the software and then reboot the system. Depending on the network configuration it might not come up on its own, in that case please start it manually with `vagrant up`. A few moments later the experimental platform web interface should be available under the address displayed by the installation script.

# Related repositories

![Overview](https://raw.githubusercontent.com/experimental-platform/experimental-platform.github.io/master/img/components.jpg)

https://github.com/experimental-platform/continuous-delivery

Meta repository which links all other repositories and triggers releases


https://github.com/experimental-platform/platform-dokku

Plugins for and configuration updates to dokku for the experimental platform


https://github.com/experimental-platform/platform-app-manager

A thin rest wrapper for dokku


https://github.com/experimental-platform/platform-buildstep

Heroku based toolchain for building and deploying applications


https://github.com/experimental-platform/platform-central-gateway

HTTP router (will probably be replaced with HAProxy)


https://github.com/experimental-platform/platform-configure

Systemd based configuration


https://github.com/experimental-platform/platform-frontend

Admin and api


https://github.com/experimental-platform/platform-hardware

udev device browser


https://github.com/experimental-platform/platform-hostname-avahi

Announcing the experimental platforms IP address via avahi/zeroconf


https://github.com/experimental-platform/platform-hostname-smb

Announcing the experimental platforms IP address via SMB/NMB protocol


https://github.com/experimental-platform/platform-monitoring

A microservice written in go that makes stats available through a simple http api


https://github.com/experimental-platform/platform-ptw

A microservice written in ruby that subscribes to the protonet publish to web interface


https://github.com/experimental-platform/platform-pulseaudio

Linux audio server


https://github.com/experimental-platform/platform-skvs

A microservice written in go that acts as a minimal key value service with a file system backend


https://github.com/experimental-platform/platform-systemd-proxy

A microservice written in go that makes certain systemd management functions available through a http api


https://github.com/experimental-platform/platform-ubuntu

An ubuntu base image that has all necessary customizations for the experimental platform

