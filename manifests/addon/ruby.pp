# Class: abrt::addon::ruby
#
# installs and configures the ruby abrt addon.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
# include abrt::addon::ruby
#
class abrt::addon::ruby {
  # http://fedoraproject.org/wiki/QA:Testcase_ABRT_ruby_gem
  include ::abrt
  $analyzer = 'Ruby'

  package { 'rubygem-abrt': ensure => $::abrt::package_ensure, } ->
  file { '/etc/libreport/events.d/ruby_event.conf':
    ensure  => file,
    content => template("${module_name}/libreport/events.d/ruby_event.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  if $::operatingsystemmajrelease == 6 {
    file { '/etc/profile.d/optymyze_ruby_load_abrt.sh':
      ensure  => 'file',
      mode    => '0644',
      content => 'export RUBYLIB=$RUBYLIB:$(find /usr/lib/ruby/gems/1.8/gems/abrt*/lib | sort | head -1)
export RUBYOPT="-rabrt"'
    }
  }
}
