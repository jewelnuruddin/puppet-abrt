# Class: abrt::libreport::reportuploader
#
# Plugin to report bugs into anonymous FTP site associated with ticketing system.
#
# Parameters:
#
# $report_uploader_cmd::         command to be used to upload reports
#                                example: 'scp://user:password@server.name/var/spool/abrt-upload || :'
#
class abrt::libreport::uploader (
  $package_ensure = $abrt::package_ensure,
  $report_uploadercmd,
) {
  include abrt

  package { 'libreport-plugin-reportuploader': ensure => $package_ensure, }

  Class['abrt::libreport::uploader'] ~> Service['abrtd']
}
