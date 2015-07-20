# Class: abrt::addon::python
#
# installs and configures the python abrt addon.
#
# Parameters:
# $requireAbsolutePath: If set to 'no', unhandled python exceptions will be caught
#                       and saved even in scripts which are run without full path
#                       in sys.argv[0].
#
# Actions:
#
# Requires:
#
# Sample Usage:
# include abrt::addon::python
#
class abrt::addon::python ($requireAbsolutePath = 'yes') {
  # http://fedoraproject.org/wiki/QA:Testcase_ABRT_python_addon
  include ::abrt
  $analyzer = 'python'

  package { 'abrt-addon-python': ensure => $::abrt::package_ensure, } ->
  file { '/etc/libreport/events.d/python_event.conf':
    ensure  => file,
    content => template("${module_name}/libreport/events.d/python_event.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  } ->
  file { '/etc/abrt/plugins/python.conf':
    ensure  => file,
    content => template("${module_name}/abrt/plugins/python.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['abrtd'],
  }
}
