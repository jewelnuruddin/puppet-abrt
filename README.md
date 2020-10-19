# abrt
[![Build Status](https://travis-ci.org/jewelnuruddin/puppet-abrt.png?branch=master)](https://travis-ci.org/jewelnuruddin/puppet-abrt)

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Development - Setup development environment](#development)
4. [Contribution - Guide for contributing to the module](#contribution)

## Overview

ABRT is a set of tools to help users detect and report problems.
It's main purpose is to ease the process of reporting an issue and finding a solution.

## Usage

    class { 'abrt':
      package_ensure         => 'latest',
      open_gpg_check         => 'no',
      autoreporting_enabled  => 'yes',
      process_unpackaged     => 'yes',
      addons                 => ['ccpp', 'kerneloops', 'python']
    }

    # abrt addons can also be selected like this
    include abrt::addon::vmcore

    # libreport settings
    include abrt::libreport::mailx

    class { 'abrt::libreport::sos': enable => false, }

    class { 'abrt::libreport::ureport':
      url           => 'https://puppet.company.net:8443/abrt',
      sslverify     => 'yes',
      sslclientauth => 'puppet',
    }

## Setup development environments

You can run smoke tests:

```sh
$ vagrant up
$ vagrant provision
```

## Contribution

* Fork the project
* Commit and push until you are happy with your contribution
* Send a pull request with a description of your changes
