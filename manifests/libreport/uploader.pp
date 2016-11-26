# Class: abrt::libreport::reportuploader
#
# Plugin to report bugs into anonymous FTP site associated with ticketing system.
#
# Parameters:
#
# $package_ensure::              Set to "installed", "latest" or any other allowed method for package type
#
# $report_uploadercmd::          Command to be used to upload reports
#                                example: 'scp://user:password@server.name/var/spool/abrt-upload || :'
#
class abrt::libreport::uploader (
  $report_uploadercmd,
  $package_ensure = $abrt::package_ensure,
) {
  include ::abrt

  package { 'libreport-plugin-reportuploader': ensure => $package_ensure, }

  Class['abrt::libreport::uploader'] ~> Service['abrtd']
}
