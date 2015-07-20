# Class: abrt::addon::kerneloops
#
# installs java abrt addon.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
# include abrt::addon::java
#
class abrt::addon::java {
  # https://github.com/jfilak/abrt-java-connector
  include ::abrt
  $analyzer = 'Java'

  package { 'abrt-java-connector': ensure => $::abrt::package_ensure, } ->
  file { '/etc/libreport/events.d/java_event.conf':
    ensure  => file,
    content => template("${module_name}/libreport/events.d/java_event.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
