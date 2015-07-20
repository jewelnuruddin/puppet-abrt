# Class: abrt::libreport::kerneloops
#
# installs and configures the kerneloops plugin.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
# include abrt::libreport::kerneloops
#
class abrt::libreport::kerneloops {
  include ::abrt

  package { 'libreport-plugin-kerneloops': ensure => $::abrt::package_ensure, }
}
