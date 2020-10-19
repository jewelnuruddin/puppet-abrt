# Class: abrt
#
# installs, configures and starts the service for abrt.
#
# Parameters:
#
# $package_ensure::                  Set to "installed", "latest" or any other allowed method for package type
#
# $watch_crashdump_archive_dir::     Enable this if you want abrtd to auto-unpack crashdump tarballs which appear
#                                    in this directory (for example, uploaded via ftp, scp etc).
#
# $max_crash_reports_size::          Max size for crash storage [MiB] or 0 for unlimited
#
# $dump_location::                   Specify where you want to store coredumps and all files which are needed for
#                                    reporting. (default:/var/spool/abrt)
#
# $delete_uploaded::                 If you want to automatically clean the upload directory you have to tweak the
#                                    selinux policy.
#
# $autoreporting_event::             A name of event which is run automatically after problem's detection. The
#                                    event should perform some fast analysis and print out THANKYOU message if the
#                                    problem is konwn.
#
# $autoreporting_enabled::           Enables automatic running of the event configured in AutoreportingEvent option.
#
# $shortened_reporting::             Enables shortened GUI reporting where the reporting is interrupted after
#                                    AutoreportingEvent is done.
#                                    Default value: Yes but only if application is running in GNOME desktop
#                                    session; otherwise No.
#
# $private_reports::                 Disable this option if you want to allow regular users to have file system
#                                    rights to read the problem data stored in DumpLocation.
#
# $open_gpg_check::                  With this option set to "yes", only crashes in signed packages will be analyzed.
#                                    the list of public keys used to check the signature is in the file gpg_keys
#
# $black_list::                      Blacklisted packages
#
# $black_listed_paths:: TBD
#
# $process_unpackaged::              Process crashes in executables which do not belong to any package?
#
# $addons::                          Also load these abrt addons.
#
class abrt (
  $package_ensure              = $abrt::params::package_ensure,
  $watch_crashdump_archive_dir = $abrt::params::watch_crashdump_archive_dir,
  $max_crash_reports_size      = $abrt::params::max_crash_reports_size,
  $dump_location               = $abrt::params::dump_location,
  $delete_uploaded             = $abrt::params::delete_uploaded,
  $autoreporting_event         = $abrt::params::autoreporting_event,
  $autoreporting_enabled       = $abrt::params::autoreporting_enabled,
  $shortened_reporting         = $abrt::params::shortened_reporting,
  $private_reports             = $abrt::params::private_reports,
  $open_gpg_check              = $abrt::params::open_gpg_check,
  $black_list                  = $abrt::params::black_list,
  $process_unpackaged          = $abrt::params::process_unpackaged,
  $black_listed_paths          = $abrt::params::black_listed_paths,
  $addons                      = $abrt::params::addons,
) inherits ::abrt::params {
  # https://fedoraproject.org/wiki/Test_Day:2015-04-14_ABRT
  # test : kill -SIGSEGV (pid)
  contain '::abrt::install'
  contain '::abrt::config'
  contain '::abrt::service'

  Class['abrt::install'] ->
  Class['abrt::config'] ~>
  Class['abrt::service']

  if ('ccpp' in $addons ) {
    class{'abrt::addon::ccpp': }
  }

  if ('java' in $addons ) {
    class{'abrt::addon::java': }
  }

  if ('kerneloops' in $addons ) {
    class{'abrt::addon::kerneloops': }
  }

  if ('python' in $addons ) {
    class{'abrt::addon::python': }
  }

  if ('ruby' in $addons ) {
    class{'abrt::addon::ruby': }
  }

  if ('vmcore' in $addons ) {
    class{'abrt::addon::vmcore': }
  }

  if ('xorg' in $addons ) {
    class{'abrt::addon::xorg': }
  }

}
