# Class: abrt::libreport::logger
#
# installs and configures the logger plugin.
#
# Parameters:
# $log_file:
#
# $append:
#
# Actions:
#
# Requires:
#
# Sample Usage:
# include abrt::libreport::logger
#
class abrt::libreport::logger ($log_file = '/var/log/abrt_reports.log', $append = 'yes',) {
  include ::abrt
  package { 'libreport-plugin-logger': ensure => $::abrt::package_ensure, } ->
  file { '/etc/libreport/events/report_Logger.conf':
    ensure  => file,
    content => template("${module_name}/libreport/plugins/logger.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['abrtd'],
  }
}
