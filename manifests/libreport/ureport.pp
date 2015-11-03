# Class: abrt::libreport::ureport
#
# Uploads micro-report to abrt server
#
# Parameters:
#
# $url::                          Base URL to uReport server
#
# $sslverify::                    no means that ssl certificates will not be checked
#
# $contactemail::                 Contact email attached to an uploaded uReport if required
#
# $sslclientauth::                Client-side authentication
#                                 None (default):
#                                 rhsm: Using RH subscription management certificate:
#                                 puppet: Using Puppet certificate:
#                                 /path/to/cert.pem:/path/to/key.pem: Using custom certificate:
#
class abrt::libreport::ureport (
  $package_ensure = $abrt::package_ensure,
  $url            = 'http://bug-report.itos.redhat.com',
  $sslverify      = 'no',
  $contactemail   = "root@${::fqdn}",
  $sslclientauth  = 'None',
) {
  include ::abrt

  package { ['libreport-plugin-ureport', 'satyr']: ensure => $package_ensure, } ->
  file { '/etc/libreport/plugins/ureport.conf':
    ensure  => file,
    content => template("${module_name}/libreport/plugins/ureport.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  } ->
  exec { '/usr/sbin/abrt-auto-reporting enabled': onlyif => '/usr/sbin/abrt-auto-reporting | /bin/grep disabled' }

  Class['abrt::libreport::ureport'] ~> Service['abrtd']
}
