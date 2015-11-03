# Class: abrt::addon::python
#
# installs and configures the python abrt addon.
#
# Parameters:
#
# $requireAbsolutePath::    If set to 'no', unhandled python exceptions will be caught
#                           and saved even in scripts which are run without full path
#                           in sys.argv[0].
#
class abrt::addon::python (
  $package_ensure      = $abrt::package_ensure,
  $requireAbsolutePath = 'yes'
) {
  # http://fedoraproject.org/wiki/QA:Testcase_ABRT_python_addon
  include ::abrt

  package { 'abrt-addon-python': ensure => $package_ensure, } ->
  file { '/etc/abrt/plugins/python.conf':
    ensure  => file,
    content => template("${module_name}/abrt/plugins/python.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  Class['abrt::addon::python'] ~> Service['abrtd']
}
