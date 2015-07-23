# abrt
[![Build Status](https://travis-ci.org/cristifalcas/puppet-abrt.png?branch=master)](https://travis-ci.org/cristifalcas/puppet-abrt)

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Development - Guide for contributing to the module](#development)

## Overview

ABRT is a set of tools to help users detect and report problems.
It's main purpose is to ease the process of reporting an issue and finding a solution.

## Usage

		include abrt

		include abrt::addon::ccpp
		include abrt::addon::kerneloops
		include abrt::addon::python
		include abrt::addon::ruby
		include abrt::addon::vmcore
		include abrt::libreport::mailx
		include abrt::libreport::ureport

## Development

* Fork the project
* Commit and push until you are happy with your contribution
* Send a pull request with a description of your changes
