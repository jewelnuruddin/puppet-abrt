# Class: abrt::libreport::mailx
#
# The simple reporter plugin which sends a report via mailx to a specified email address.
#
# Parameters:
#
# $package_ensure::                  Set to "installed", "latest" or any other allowed method for package type
#
# $subject:: TBD
#
# $emailfrom:: TBD
#
# $emailto:: TBD
#
# $sendbinarydata:: TBD
#
class abrt::libreport::mailx (
  $package_ensure = $abrt::package_ensure,
  $subject        = '[abrt] a crash has been detected',
  $emailfrom      = "abrt@${::fqdn}",
  $emailto        = "root@${::fqdn}",
  $sendbinarydata = 'no',
  $include_backtrace_ccpp = false,
) {
  include ::abrt

  package { 'libreport-plugin-mailx': ensure => $package_ensure, } ->
  file { '/etc/libreport/plugins/mailx.conf':
    ensure  => file,
    content => template("${module_name}/libreport/plugins/mailx.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }->
  file { '/etc/libreport/events.d/mailx_event.conf':
    ensure  => file,
    content => template("${module_name}/libreport/events.d/mailx_event.conf.el${::operatingsystemmajrelease}"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  Class['abrt::libreport::mailx'] ~> Service['abrtd']
}
