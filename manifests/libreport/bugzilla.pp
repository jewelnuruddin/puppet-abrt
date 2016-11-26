# Class: abrt::libreport::bugzilla
#
# Plugin to report bugs into the bugzilla.
#
# Parameters:
#
# $package_ensure::                  Set to "installed", "latest" or any other allowed method for package type
#
# $bugzillaurl::                  Bugzilla URL
#
# $sslverify::                    yes means that ssl certificates will be checked
#
# $login::                        your login has to exist, if you don have any, please create one
#
# $password::                     your password
#
class abrt::libreport::bugzilla (
  $login,
  $password,
  $package_ensure = $abrt::package_ensure,
  $bugzillaurl    = 'https://bugzilla.redhat.com/',
  $sslverify      = 'yes',
) {
  include ::abrt

  package { ['libreport-plugin-bugzilla']: ensure => $package_ensure, } ->
  file { '/etc/libreport/events/report_Bugzilla.conf':
    ensure  => file,
    content => template("${module_name}/libreport/events/report_Bugzilla.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  } ->
  file { '/etc/libreport/plugins/bugzilla.conf':
    ensure  => file,
    content => template("${module_name}/libreport/plugins/bugzilla.conf.el${::operatingsystemmajrelease}"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  Class['abrt::libreport::bugzilla'] ~> Service['abrtd']
}
