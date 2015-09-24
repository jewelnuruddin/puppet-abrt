# Default parameters for abrt module
class abrt::params {
  $package_ensure = 'installed'
  # abrt.conf
  $watchCrashdumpArchiveDir = '/var/spool/abrt-upload'
  $maxCrashReportsSize = 1000
  $dumpLocation = '/var/spool/abrt'
  $deleteUploaded = 'no'

  case $::operatingsystemmajrelease {
    6       : { $autoreportingEvent = 'submit_uReport' }
    7       : { $autoreportingEvent = 'report_uReport' }
    default : { $autoreportingEvent = 'report_uReport' }
  }
  $autoreportingEnabled = 'no'
  $shortenedReporting = undef
  $privateReports = 'yes'

  # abrt-action-save-package-data.conf
  $openGPGCheck = 'yes'
  $blackList = ['nspluginwrapper', 'valgrind', 'strace', 'mono-core']
  $processUnpackaged = 'no'
  $blackListedPaths = ['/usr/share/doc/*', '*/example*', '/usr/bin/nspluginviewer', '/usr/lib/xulrunner-*/plugin-container']
}
