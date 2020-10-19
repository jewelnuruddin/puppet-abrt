# Default parameters for abrt module
class abrt::params {
  $package_ensure = 'installed'
  # abrt.conf
  $watch_crashdump_archive_dir = '/var/spool/abrt-upload'
  $max_crash_reports_size = 1000
  $dump_location = '/var/spool/abrt'
  $delete_uploaded = 'no'

  case $::operatingsystemmajrelease {
    '6'       : { $autoreporting_event = 'submit_uReport' }
    '7'       : { $autoreporting_event = 'report_uReport' }
    default : { $autoreporting_event = 'report_uReport' }
  }
  $autoreporting_enabled = 'no'
  $shortened_reporting = undef
  $private_reports = 'yes'

  # abrt-action-save-package-data.conf
  $open_gpg_check = 'yes'
  $black_list = ['nspluginwrapper', 'valgrind', 'strace', 'mono-core']
  $process_unpackaged = 'no'
  $black_listed_paths = ['/usr/share/doc/*', '*/example*', '/usr/bin/nspluginviewer', '/usr/lib/xulrunner-*/plugin-container']

  # default addons
  $addons = []
}
