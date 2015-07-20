# Class: abrt::addon::ccpp
#
# installs, configures and starts the service for the ccpp abrt addon.
#
# Parameters:
# $makecompatcore: If you also want to dump file named "core"
#                 in crashed process' current dir, set to "yes"
#
# $savebinaryimage: Do you want a copy of crashed binary be saved?
#                  (useful, for example, when _deleted binary_ segfaults)
#
# $verboselog: Used for debugging the hook
#
# $debuginfoLocation: Specify where you want to store debuginfos (default: /var/cache/abrt-di)
#
# Actions:
#
# Requires:
#
# Sample Usage:
# include abrt::addon::ccpp
#
class abrt::addon::ccpp (
  $makecompatcore    = 'yes',
  $savebinaryimage   = 'no',
  $verboselog        = undef,
  $debuginfoLocation = '/var/cache/abrt-di',
) {
  # http://fedoraproject.org/wiki/QA:Testcase_ABRT_CCPP_addon
  include ::abrt
  $analyzer = 'CCpp'

  package { 'abrt-addon-ccpp': ensure => $::abrt::package_ensure, } ->
  file { '/etc/abrt/plugins/CCpp.conf':
    ensure  => file,
    content => template("${module_name}/abrt/plugins/CCpp.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['abrtd'],
  } ->
  file { '/etc/libreport/events.d/ccpp_event.conf':
    ensure  => file,
    content => template("${module_name}/libreport/events.d/ccpp_event.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  } ->
  file { '/etc/libreport/events.d/gconf_event.conf':
    ensure  => file,
    content => template("${module_name}/libreport/events.d/gconf_event.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  } ->
  file { '/etc/libreport/events.d/vimrc_event.conf':
    ensure  => file,
    content => template("${module_name}/libreport/events.d/vimrc_event.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  } ~>
  service { 'abrt-ccpp':
    ensure  => running,
    enable  => true,
    require => Service['abrtd'],
  }
}
