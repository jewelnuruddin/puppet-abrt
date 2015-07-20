# configures abrt
class abrt::config {
  file { '/etc/abrt/abrt-action-save-package-data.conf':
    ensure  => file,
    content => template("${module_name}/abrt/abrt-action-save-package-data.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { '/etc/abrt/abrt.conf':
    ensure  => file,
    content => template("${module_name}/abrt/abrt.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { '/etc/libreport/events.d/abrt_event.conf':
    ensure  => file,
    content => template("${module_name}/libreport/events.d/abrt_event.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { '/etc/libreport/events.d/smart_event.conf':
    ensure  => file,
    content => template("${module_name}/libreport/events.d/smart_event.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { '/etc/profile.d/abrt-console-notification.sh':
    ensure  => file,
    content => template("${module_name}/profile.d/abrt-console-notification.sh"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
