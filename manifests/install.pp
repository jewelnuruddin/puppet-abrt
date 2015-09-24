# Installs default abrt packages
class abrt::install {
  # extra packages: abrt-action-generate-machine-id needs python-argparse
  if $::operatingsystemmajrelease == 6 {
    package { ['python-argparse']: ensure => $abrt::package_ensure, }
  } else {
  }

  package { ['abrt',]: ensure => $abrt::package_ensure, }
}
