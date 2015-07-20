# Class: abrt::libreport::mailx
#
# installs and configures the mailx plugin.
#
# Parameters:
# $bugzillaurl: Bugzilla URL
#
# $sslverify: yes means that ssl certificates will be checked
#
# $login: your login has to exist, if you don have any, please create one
#
# $password: your password
#
# Actions:
#
# Requires:
#
# Sample Usage:
# include abrt::libreport::mailx
#
class abrt::libreport::bugzilla ($bugzillaurl = 'https://bugzilla.redhat.com/', $sslverify = 'yes', $login, $password,) {
  include ::abrt
  package { ['libreport-plugin-bugzilla', 'libreport-rhel-bugzilla']: ensure => $::abrt::package_ensure, } ->
  file { '/etc/libreport/plugins/bugzilla.conf':
    ensure  => file,
    content => template("${module_name}/libreport/plugins/bugzilla.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['abrtd'],
  }
}
