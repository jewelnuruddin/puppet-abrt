# Class: abrt::libreport::gui
#
# Plugin to report bugs to gui
#
# Parameters:
#
class abrt::libreport::gui (
  $package_ensure = $abrt::package_ensure,
) {
  include ::abrt

  package { ['abrt-gui']: ensure => $package_ensure, }

  Class['abrt::libreport::gui'] ~> Service['abrtd']
}
