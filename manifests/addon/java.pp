# Class: abrt::addon::kerneloops
#
# installs java abrt addon.
#
# Parameters:
#
# $package_ensure::                  Set to "installed", "latest" or any other allowed method for package type
#
# $executable:: TBD
#
# $syslog:: TBD
#
# $journald:: TBD
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# include abrt::addon::java
#
class abrt::addon::java (
  $package_ensure = $abrt::package_ensure,
  $executable     = 'threadclass',
  $syslog         = 'off',
  $journald       = 'on',
) {
  # https://github.com/jfilak/abrt-java-connector
  include ::abrt

  # el7 only
  package { 'abrt-java-connector': ensure => $package_ensure, } ->
  file { '/etc/abrt/plugins/java.conf':
    ensure  => file,
    content => template("${module_name}/abrt/plugins/java.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  Class['abrt::addon::java'] ~> Service['abrtd']
}
