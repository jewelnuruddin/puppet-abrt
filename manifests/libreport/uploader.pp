# Class: abrt::libreport::reportuploader
#
# installs and configures the reportuploader plugin.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
# include abrt::libreport::reportuploader
#
class abrt::libreport::uploader {
  include ::abrt

  package { 'libreport-plugin-reportuploader': ensure => $::abrt::package_ensure, } ->
  file { '/etc/libreport/events.d/uploader_event.conf':
    ensure  => file,
    content => template("${module_name}/libreport/events.d/uploader_event.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
