# Default parameters for abrt module
class abrt::params {
  $package_ensure           = 'installed'
  # abrt.conf
  $watchCrashdumpArchiveDir = '/var/spool/abrt-upload'
  $maxCrashReportsSize      = 1000
  $dumpLocation             = '/var/spool/abrt'
  $deleteUploaded           = 'no'
  $autoreportingEvent       = 'report_uReport'
  $autoreportingEnabled     = 'no'
  # abrt-action-save-package-data.conf
  $openGPGCheck             = 'yes'
  $blackList                = ['nspluginwrapper', 'valgrind', 'strace', 'mono-core']
  $processUnpackaged        = 'no'
  $blackListedPaths         = [
    '/usr/share/doc/*',
    '*/example*',
    '/usr/bin/nspluginviewer',
    '/usr/lib/xulrunner-*/plugin-container']
  $report_sos               = true
  $report_uploader          = false
  $report_uploader_cmd      = 'scp://user:password@server.name/var/spool/abrt-upload || :'
  $report_Bugzilla          = false
  $report_uReport           = false
  $report_gui               = false
  $report_cli               = true
}
