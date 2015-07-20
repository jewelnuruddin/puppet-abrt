# Class: abrt
#
# installs, configures and starts the service for abrt.
#
# Parameters:
# $package_ensure: Set to "installed", "latest" or any other allowed method for package type
#
# $watchCrashdumpArchiveDir: Enable this if you want abrtd to auto-unpack crashdump tarballs which appear
#                            in this directory (for example, uploaded via ftp, scp etc).
#
# $maxCrashReportsSize: Max size for crash storage [MiB] or 0 for unlimited
#
# $dumpLocation: Specify where you want to store coredumps and all files which are needed for
#                reporting. (default:/var/spool/abrt)
#
# $deleteUploaded: If you want to automatically clean the upload directory you have to tweak the
#                  selinux policy.
#
# $autoreportingEvent: A name of event which is run automatically after problem's detection. The
#                      event should perform some fast analysis and print out THANKYOU message if the
#                      problem is konwn.
#
# $autoreportingEnabled: Enables automatic running of the event configured in AutoreportingEvent option.
#
# $openGPGCheck: With this option set to "yes", only crashes in signed packages will be analyzed.
#                the list of public keys used to check the signature is in the file gpg_keys
#
# $blackList: Blacklisted packages
#
# $processUnpackaged: Process crashes in executables which do not belong to any package?
#
# $blackListedPaths: Blacklisted executable paths (shell patterns)
#
# Actions:
#
# Requires:
#
# Sample Usage:
# include abrt::addon::ccpp
#
class abrt (
  $package_ensure           = $abrt::params::package_ensure,
  $watchCrashdumpArchiveDir = $abrt::params::watchCrashdumpArchiveDir,
  $maxCrashReportsSize      = $abrt::params::maxCrashReportsSize,
  $dumpLocation             = $abrt::params::dumpLocation,
  $deleteUploaded           = $abrt::params::deleteUploaded,
  $autoreportingEvent       = $abrt::params::autoreportingEvent,
  $autoreportingEnabled     = $abrt::params::autoreportingEnabled,
  $openGPGCheck             = $abrt::params::openGPGCheck,
  $blackList                = $abrt::params::blackList,
  $processUnpackaged        = $abrt::params::processUnpackaged,
  $blackListedPaths         = $abrt::params::blackListedPaths,
  $report_sos               = $abrt::params::report_sos,
  $report_uploader          = $abrt::params::report_uploader,
  $report_uploader_cmd      = $abrt::params::report_uploader_cmd,
  $report_Bugzilla          = $abrt::params::report_Bugzilla,
  $report_uReport           = $abrt::params::report_uReport,
  $report_gui               = $abrt::params::report_gui,
  $report_cli               = $abrt::params::report_cli,
  ) inherits ::abrt::params {
  # test : kill -SIGSEGV (pid)
  contain abrt::install
  contain abrt::config
  contain abrt::service

  Class['abrt::install'] ->
  Class['abrt::config'] ~>
  Class['abrt::service']
}
