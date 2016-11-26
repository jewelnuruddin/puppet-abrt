# Class: abrt::addon::ccpp
#
# installs, configures and starts the service for the ccpp abrt addon.
#
# Parameters:
#
# $package_ensure::                 Set to "installed", "latest" or any other allowed method for package type
#
# $makecompatcore::                 If you also want to dump file named "core"
#                                   in crashed process' current dir, set to "yes"
#
# $savebinaryimage::                Do you want a copy of crashed binary be saved?
#                                   (useful, for example, when _deleted binary_ segfaults)
#
# $verboselog::                     Used for debugging the hook
#
# $debuginfo_location::             Specify where you want to store debuginfos (default: /var/cache/abrt-di)
#
# $allowed_users::                  allowed_users
#
# $allowed_groups::                 allowed_groups
#
class abrt::addon::ccpp (
  $package_ensure    = $abrt::package_ensure,
  $makecompatcore    = 'yes',
  $savebinaryimage   = 'no',
  $verboselog        = 2,
  $debuginfo_location = '/var/cache/abrt-di',
  $allowed_users      = undef,
  $allowed_groups     = undef,
) {
  # http://fedoraproject.org/wiki/QA:Testcase_ABRT_CCPP_addon
  include ::abrt

  package { 'abrt-addon-ccpp': ensure => $package_ensure, } ->
  file { '/etc/abrt/plugins/CCpp.conf':
    ensure  => file,
    content => template("${module_name}/abrt/plugins/CCpp.conf"),
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
