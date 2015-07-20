# Class: abrt::libreport::mailx
#
# installs and configures the mailx plugin.
#
# Parameters:
# $subject:
#
# $emailfrom:
#
# $emailto:
#
# $sendbinarydata:
#
# Actions:
#
# Requires:
#
# Sample Usage:
# include abrt::libreport::mailx
#
class abrt::libreport::mailx (
  $subject        = '[abrt] full crash report',
  $emailfrom      = "abrt@${::fqdn}",
  $emailto        = "root@${::fqdn}",
  $sendbinarydata = 'no',) {
  include ::abrt
  package { 'libreport-plugin-mailx': ensure => $::abrt::package_ensure, } ->
  file { '/etc/libreport/events.d/mailx_event.conf':
    ensure  => file,
    content => template("${module_name}/libreport/events.d/mailx_event.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  } ->
  file { '/etc/libreport/plugins/mailx.conf':
    ensure  => file,
    content => template("${module_name}/libreport/plugins/mailx.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['abrtd'],
  }
}
