# Installs default abrt packages
class abrt::install {
  package { ['abrt',]: ensure => $::abrt::package_ensure, }

  if $::abrt::reportuploader {
    include abrt::libreport::uploader
  }

  if $::abrt::report_Bugzilla {
    include abrt::libreport::bugzilla
  }

  if $::abrt::report_uReport {
    include abrt::libreport::ureport
  }

  if $::abrt::report_gui {
    package { ['abrt-gui',]: ensure => $::abrt::package_ensure, }
  }

  if $::abrt::report_cli {
    package { ['abrt-tui', 'abrt-console-notification',]: ensure => $::abrt::package_ensure, }
  }
}
