# Class: abrt::addon::vmcore
#
# installs, configures and starts the service for the vmcore abrt addon.
#
# Parameters:
#
# $copyvmcore::      Do you want vmcore to be copied, or moved from /var/crash to /var/spool/abrt?
#                    (default is to copy, but it may duplicate way too much data)
#
class abrt::addon::vmcore (
  $package_ensure  = $abrt::package_ensure,
  $copyvmcore      = 'yes',
  $attempthardlink = 'no',
) {
  # http://fedoraproject.org/wiki/QA:Testcase_ABRT_vmcore
  include ::abrt
  include ::abrt::addon::kerneloops

  if $::operatingsystemmajrelease == 6 {
    $vmcore_conf = '/etc/abrt/abrt-harvest-vmcore.conf'
  } else {
    $vmcore_conf = '/etc/abrt/plugins/vmcore.conf'
  }

  package { 'abrt-addon-vmcore': ensure => $package_ensure, } ->
  file { $vmcore_conf:
    ensure  => file,
    content => template("${module_name}/abrt/plugins/vmcore.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  } ->
  file { '/var/crash/':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  } ->
  file { '/var/crash/bug_1144509':
    ensure  => file,
    content => 'fixes https://bugzilla.redhat.com/show_bug.cgi?id=1144509',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  } ~>
  service { 'abrt-vmcore':
    ensure  => running,
    enable  => true,
    require => Service['abrtd'],
  }
}
