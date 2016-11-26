# Class: abrt::libreport::kerneloops
#
# This package contains plugin which sends kernel crash information to specified server, usually to kerneloops.org.
#
# Parameters:
#
# $package_ensure::                  Set to "installed", "latest" or any other allowed method for package type
#
class abrt::libreport::kerneloops (
  $package_ensure = $abrt::package_ensure,
) {
  include ::abrt

  package { 'libreport-plugin-kerneloops': ensure => $package_ensure, }

  Class['abrt::libreport::kerneloops'] ~> Service['abrtd']
}
