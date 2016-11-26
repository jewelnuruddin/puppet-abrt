# Class: abrt::libreport::cli
#
# Plugin to report to cli
#
# Parameters:
#
# $package_ensure::                  Set to "installed", "latest" or any other allowed method for package type
#
class abrt::libreport::cli (
  $package_ensure = $abrt::package_ensure,
) {
  include ::abrt

  package { ['abrt-tui', 'abrt-console-notification']: ensure => $package_ensure, }

  Class['abrt::libreport::cli'] ~> Service['abrtd']
}
