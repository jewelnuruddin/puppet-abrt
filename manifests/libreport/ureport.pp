# Class: abrt::libreport::ureport
#
# installs and configures the ureport plugin.
#
# Parameters:
# $url: Base URL to uReport server
#
# $sslverify: no means that ssl certificates will not be checked
#
# $contactemail: Contact email attached to an uploaded uReport if required
#
# $sslclientauth: Client-side authentication
#                 None (default):
#                 rhsm: Using RH subscription management certificate:
#                 puppet: Using Puppet certificate:
#                 /path/to/cert.pem:/path/to/key.pem: Using custom certificate:
#
# Actions:
#
# Requires:
#
# Sample Usage:
# include abrt::libreport::ureport
#
class abrt::libreport::ureport (
  $url           = 'http://bug-report.itos.redhat.com',
  $sslverify     = 'no',
  $contactemail  = "root@${::fqdn}",
  $sslclientauth = 'puppet',) {
  include ::abrt
  package { 'libreport-plugin-ureport': ensure => $::abrt::package_ensure, } ->
  file { '/etc/libreport/plugins/ureport.conf':
    ensure  => file,
    content => template("${module_name}/libreport/plugins/ureport.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['abrtd'],
  }
}
