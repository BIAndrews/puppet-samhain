# == Class: samhain
#
# Samhain installation and setup.
#
# === Parameters
#
# Document parameters here.
#
# [*deploysrc*]
#   http(s), ftp, s3 sources to get the samhain agent binary from. This
#   can be a zip, tar.gz, or tar.gz2 source. Do not include directories in the
#   zip or tarball, just the single 'samhain' binary file.
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  See example/init.pp file.
#
# === Authors
#
# Bryan Andrews <bryanandrews@gmail.com>
#
# === Copyright
#
# Copyright 2015 Bryan Andrews, unless otherwise noted.
#

class samhain (

  $deploysrc = undef, # http(s), ftp, s3 source HREF
  $settings  = $samhain::params::settings

) inherits samhain::params {

  sys::inifile { $samhain::params::configfile:
    config => $settings,
    notify => Service['samhain'],
  }

  $srcfilename = basename($deploysrc)
  $target = dirname($samhain::params::fullpath)

  staging::deploy { $srcfilename:
    source => $deploysrc,
    target => $target,
  }

  file { $samhain::params::fullpath:
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0700',
    require => Staging::Deploy[$srcfilename],
  }

  file { '/etc/init.d/samhain':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0700',
    content => template('samhain/samhain.startLSB.erb'),
    require => File[$samhain::params::fullpath],
  }

  file { '/var/lib/samhain':
    ensure => directory,
    mode   => '0600',
    owner  => root,
    group  => root,
  }

  file { '/var/run/samhain':
    ensure => directory,
    mode   => '0600',
    owner  => root,
    group  => root,
  }

  exec { 'samhain agent init':
    path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    command => "${::fullpath} -t init",
    creates => '/var/lib/samhain/samhain_file',
    require => File[$samhain::params::fullpath],
  }

  service { 'samhain':
    ensure  => running,
    require => [
      File['/etc/init.d/samhain'],
      File['/var/run/samhain'],
      File['/var/lib/samhain'],
      Exec['samhain agent init'],
    ],
  }

}
