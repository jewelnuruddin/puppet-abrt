# Class: abrt::libreport::sos
#
# The simple reporter plugin which sends sos reports
#
# Parameters:
#
# $package_ensure::                  Set to "installed", "latest" or any other allowed method for package type
#
# $enable:: TBD
#
class abrt::libreport::sos (
  $package_ensure = $abrt::package_ensure,
  $enable = true,
) {
  # https://fedoraproject.org/wiki/QA:Testcase_ABRT_sosreport
  include ::abrt

  package { 'sos': ensure => $package_ensure, }

  if $enable {
    exec { 'enable sos reports':
      command => '/bin/sed "s/^#\(\s*nice sosreport\)/\1/" -i /etc/libreport/events.d/abrt_event.conf',
      onlyif  => '/bin/grep "^#\s*nice sosreport" /etc/libreport/events.d/abrt_event.conf',
    }
  } else {
    exec { 'disable sos reports':
      command => '/bin/sed "s/^\(\s*nice sosreport\)/#\1/" -i /etc/libreport/events.d/abrt_event.conf',
      onlyif  => '/bin/grep "^\s*nice sosreport" /etc/libreport/events.d/abrt_event.conf',
    }
  }

  Class['abrt::config'] -> Class['abrt::libreport::sos']
  Class['abrt::libreport::sos'] ~> Service['abrtd']
}
