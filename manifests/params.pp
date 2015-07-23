# lets pretend this is documentation, k?
class samhain::params {

  $prefix        = '/usr'
  $fullpath      = "${prefix}/sbin/samhain"  # path to samhain binary
  $agentkey      = '4142434445464748'
  $configfile    = '/etc/samhainrc'

  # INI file format
  $settings = {
    'ReadOnly' => {
      'dir' => '0/',
      'dir' => '99/etc',
      'dir' => '99/boot',
      'dir' => '99/sbin',
      'dir' => '99/bin',
      'dir' => '99/lib',
      'dir' => '99/usr',
      'dir' => '99/var',
    },
    'Attributes' => {
      'file' => '/tmp',
      'file' => '/dev',
      'file' => '/proc',
      'file' => '/sys',
      'file' => '/etc/mtab',
      'file' => '/etc/adjtime',
      'file' => '/etc/fstab',
      'file' => '/etc',
      'dir'  => '99/dev',
    },
    'IgnoreAll' => {
      'file' => '/dev/ppp',
      'dir'  => '-1/dev/pts',
      'dir'  => '-1/var/cache',
      'dir'  => '-1/var/games',
      'dir'  => '-1/var/gdm',
      'dir'  => '-1/var/lock',
      'dir'  => '-1/var/mail',
      'dir'  => '-1/var/run',
      'dir'  => '-1/var/spool',
      'dir'  => '-1/var/tmp',
      'dir'  => '99/var/opt/lib/pe-puppet',
    },
    'GrowingLogFiles' => {
      'dir' => '99/var/log',
    },
    'Misc' => {
      'Daemon' => 'yes',
      'ChecksumTest' => 'check',
      'SetLoopTime' => '600',
      'SetFileCheckTime' => '7200',
      'SyslogFacility' => 'LOG_LOCAL2',
      'IgnoreAdded' => '/var/log/.*\.[0-9]+$',
      'IgnoreAdded' => '/var/log/.*\.[0-9]+\.gz$',
      'IgnoreAdded' => '/var/log/.*\.[0-9]+\.log$',
      'IgnoreAdded' => '/var/log/[[:alnum:]]+/.*\.[0-9]+$',
      'IgnoreAdded' => '/var/log/[[:alnum:]]+/.*\.[0-9]+\.gz$',
      'IgnoreAdded' => '/var/log/[[:alnum:]]+/.*\.[0-9]+\.log$',
      'IgnoreAdded' => '/var/lib/slocate/slocate.db.tmp',
      'IgnoreMissing' => '/var/lib/slocate/slocate.db.tmp',
    },
  }

  case $::osfamily {
    'redhat': {
      package { 'redhat-lsb-core': ensure => installed }
    }
    'debian': {
      package { 'lsb-base': ensure => installed }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }


}
