# Class: abrt::addon::ruby
#
# installs and configures the ruby abrt addon.
#
# Parameters: None
#
class abrt::addon::ruby (
  $package_ensure = $abrt::package_ensure,
) {
  # http://fedoraproject.org/wiki/QA:Testcase_ABRT_ruby_gem
  include ::abrt

  package { 'rubygem-abrt': ensure => $package_ensure, }

  if $::operatingsystemmajrelease == 6 {
    file { '/etc/profile.d/optymyze_ruby_load_abrt.sh':
      ensure  => 'file',
      mode    => '0644',
      content => 'export RUBYLIB=$RUBYLIB:$(find /usr/lib/ruby/gems/1.8/gems/abrt*/lib | sort | head -1)
export RUBYOPT="-rabrt"',
    }
  }

  Class['abrt::addon::ruby'] ~> Service['abrtd']
}
