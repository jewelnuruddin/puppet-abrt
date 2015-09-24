# Class: abrt::addon::kerneloops
#
# installs and starts the service for the kerneloops abrt addon.
#
# Parameters: None
#
class abrt::addon::kerneloops (
  $package_ensure = $abrt::package_ensure,
) {
  # http://fedoraproject.org/wiki/QA:Testcase_ABRT_kernel_addon
  include abrt
  include abrt::libreport::kerneloops

  package { 'abrt-addon-kerneloops': ensure => $package_ensure, } ->
  file { '/etc/abrt/plugins/oops.conf':
    ensure  => file,
    content => template("${module_name}/abrt/plugins/oops.conf.el${::operatingsystemmajrelease}"),
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
