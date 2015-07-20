# Class: abrt::addon::vmcore
#
# installs, configures and starts the service for the vmcore abrt addon.
#
# Parameters:
# $copyvmcore: Do you want vmcore to be copied, or moved from /var/crash to /var/spool/abrt?
#              (default is to copy, but it may duplicate way too much data)
#
# Actions:
#
# Requires:
#
# Sample Usage:
# include abrt::addon::vmcore
#
class abrt::addon::vmcore ($copyvmcore = 'yes',) {
  # http://fedoraproject.org/wiki/QA:Testcase_ABRT_vmcore
  include ::abrt
  $analyzer = 'vmcore'

  if $::operatingsystemmajrelease == 6 {
    $vmcore_conf = '/etc/abrt/abrt-harvest-vmcore.conf'
  } else {
    $vmcore_conf = '/etc/abrt/plugins/vmcore.conf'
  }

  package { 'abrt-addon-vmcore': ensure => $::abrt::package_ensure, } ->
  file { $vmcore_conf:
    ensure  => file,
    content => template("${module_name}/abrt/plugins/vmcore.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['abrtd'],
  } ->
  file { '/etc/libreport/events.d/vmcore_event.conf':
    ensure  => file,
    content => template("${module_name}/libreport/events.d/vmcore_event.conf"),
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
    before  => Service['abrt-vmcore'],
  } ~>
  service { 'abrt-vmcore':
    ensure  => running,
    enable  => true,
    require => Service['abrtd'],
  }
}
