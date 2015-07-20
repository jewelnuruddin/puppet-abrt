# Class: abrt::addon::kerneloops
#
# installs and starts the service for the kerneloops abrt addon.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
# include abrt::addon::kerneloops
#
class abrt::addon::kerneloops {
  # http://fedoraproject.org/wiki/QA:Testcase_ABRT_kernel_addon
  include ::abrt
  include ::abrt::libreport::kerneloops
  $analyzer = 'Kerneloops'

  package { 'abrt-addon-kerneloops': ensure => $::abrt::package_ensure, } ->
  file { '/etc/libreport/events.d/koops_event.conf':
    ensure  => file,
    content => template("${module_name}/libreport/events.d/koops_event.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  } ~>
  service { 'abrt-oops':
    ensure  => running,
    enable  => true,
    require => Service['abrtd'],
  }
}
