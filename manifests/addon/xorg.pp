# Class: abrt::addon::xorg
#
# installs, configures and starts the service for the xorg abrt addon.
#
# Parameters:
# $blacklistedXorgModules: List of modules which, when loaded, should make
#                          Xorg crashes non-reportable. Names should be without "_drv.so" suffix:
#
# Actions:
#
# Requires:
#
# Sample Usage:
# include abrt::addon::xorg
#
class abrt::addon::xorg ($blacklistedXorgModules = 'nvidia, fglrx, vboxvideo',) {
  include ::abrt
  $analyzer = 'xorg'

  package { 'abrt-addon-xorg': ensure => $::abrt::package_ensure, } ->
  file { '/etc/abrt/plugins/xorg.conf':
    ensure  => file,
    content => template("${module_name}/abrt/plugins/xorg.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['abrtd'],
  } ->
  file { '/etc/libreport/events.d/xorg_event.conf':
    ensure  => file,
    content => template("${module_name}/libreport/events.d/xorg_event.conf"),
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
