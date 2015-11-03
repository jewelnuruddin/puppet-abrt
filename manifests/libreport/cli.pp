# Class: abrt::libreport::cli
#
# Plugin to report to cli
#
# Parameters:
#
class abrt::libreport::cli (
  $package_ensure = $abrt::package_ensure,
) {
  include ::abrt

  package { ['abrt-tui', 'abrt-console-notification']: ensure => $package_ensure, }

  Class['abrt::libreport::cli'] ~> Service['abrtd']
}
