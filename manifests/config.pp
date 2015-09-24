# configures abrt
class abrt::config {
  file { '/etc/abrt/abrt-action-save-package-data.conf':
    ensure  => file,
    content => template("${module_name}/abrt/abrt-action-save-package-data.conf.el${::operatingsystemmajrelease}"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { '/etc/abrt/abrt.conf':
    ensure  => file,
    content => template("${module_name}/abrt/abrt.conf.el${::operatingsystemmajrelease}"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  # fix for el7
  file { '/etc/profile.d/abrt-console-notification.sh':
    ensure  => file,
    content => template("${module_name}/profile.d/abrt-console-notification.sh"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
