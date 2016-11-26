# Class: abrt::addon::xorg
#
# installs, configures and starts the service for the xorg abrt addon.
#
# Parameters: None
#
# $package_ensure::                  Set to "installed", "latest" or any other allowed method for package type
#
# $blacklisted_xorg_modules:: TBD
#
class abrt::addon::xorg (
  $package_ensure         = $abrt::package_ensure,
  $blacklisted_xorg_modules = 'nvidia, fglrx, vboxvideo',
) {
  include ::abrt

  # el7 only
  package { 'abrt-addon-xorg': ensure => $package_ensure, } ->
  file { '/etc/abrt/plugins/xorg.conf':
    ensure  => file,
    content => template("${module_name}/abrt/plugins/xorg.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  } ~>
  service { 'abrt-xorg':
    ensure  => running,
    enable  => true,
    require => Service['abrtd'],
  }
}
