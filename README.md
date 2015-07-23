#samhain

####Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with samhain](#setup)
3. [Creating Binaries - Downloading and Compilig your binaries](#creating-binaries)
4. [Limitations - OS compatibility, etc.](#limitations)

##Overview

This Puppet samhain module installs, configures, and manages the Samhain HIDS service. This is not your typical turn key solution. The binary needs to be compiled for your platform and hosted in zip or tar.gz format in your environment.

##Setup

###What samhain affects

* samhain binaries.
* samhain configuration file.
* samhain service.

###Beginning with samhain

Pre-compiled binary installation, config assurance, and service setup.
~~~
class { 'samhain':
  deploysrc => 'http://localhost/samhain.zip',
}
~~~

##Creating Binaries

This is the agent/client that runs on the nodes. There is no vendor provided packages or binaries as each installation is different and can contain keys in the binary itself for security.

Download and unzip the source from here: http://www.la-samhna.de/samhain/samhain-current.tar.gz
```
yum -y install glibc-static zlib zlib-devel zlib-static ImageMagick
yum -y groupinstall "development tools"
# please take note, these directories are required or the agent init will fail
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libdir=/var/lib --enable-srp --enable-suidcheck --enable-port-check \
--enable-process-check --enable-login-watch --with-pid-file=/var/run/samhain/samhain.pid
make
# now you have a static samhain binary to zip and distribute
```

