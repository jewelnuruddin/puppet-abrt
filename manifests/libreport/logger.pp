# Class: abrt::libreport::logger
#
# The simple reporter plugin which writes a report to a specified file.
#
# Parameters:
#
# $log_file::                   Path to file where to write reports
#
# $append::                     Append reports
#
class abrt::libreport::logger (
  $package_ensure = $abrt::package_ensure,
  $log_file       = '/var/log/abrt_reports.log',
  $append         = 'yes',
) {
  # https://fedoraproject.org/wiki/QA:Testcase_ABRT_Logger_plugin?rd=QA:Testcase_ABRT_Logger
  include ::abrt

  package { 'libreport-plugin-logger': ensure => $package_ensure, }  ->
  file { '/etc/libreport/events/report_Logger.conf':
    ensure  => file,
    content => template("${module_name}/libreport/events/report_Logger.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  Class['abrt::libreport::logger'] ~> Service['abrtd']
}
