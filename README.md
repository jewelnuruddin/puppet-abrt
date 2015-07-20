# abrt #

This module configures [abrt](https://github.com/abrt/abrt/wiki/ABRT-Project). It was only tested with el6 and el7.

# Quick Start #

This module is split in 3 parts:

* abrt init class that takes care of installation and configuration of abrt
* abrt::addon::_name_ that takes care of installation and configuration of different abrt-addon-_name_
* abrt::libreport::_name_ that takes care of installation and configuration of different libreport-plugin-_name_

All classes have the parameters set to the default values from the packages.

Example installation:

	  class { 'abrt':
	    openGPGCheck         => 'no',
	    autoreportingEnabled => 'yes',
	  }
	  include abrt::addon::ccpp
	  include abrt::addon::kerneloops
	  include abrt::addon::python
	  include abrt::addon::ruby
	  include abrt::libreport::mailx
	  class { 'abrt::libreport::ureport':
	    url       => "https://${::puppetmaster}:8443/abrt",
	    sslverify => 'no'
	  }

The above installs abrt and disables the check for sign packages and also is enabling the default
reporting module ([ureport](https://github.com/abrt/faf/wiki/uReport)).

It will install the abrt addons for cpp, kerneloops, python and ruby.

It will enable and configure the mail and ureport plugins. ureport is configured to be used with 
[foreman abrt smart proxy](https://github.com/theforeman/smart_proxy_abrt) module.

# Testing #

1. Install will-crash package
2. Use one of the relevant programs:

	* /bin/will_abort
	* /bin/will_cpp\_segfault
	* /bin/will_java\_segfault
	* /bin/will_java\_throw
	* /bin/will_java\_throw\_remote
	* /bin/will_java\_throw\_suppressed
	* /bin/will_oops
	* /bin/will_python3\_raise
	* /bin/will_python\_raise
	* /bin/will_python\_sigsegv
	* /bin/will_ruby\_raise
	* /bin/will_segfault
	* /bin/will_stackoverflow


# Contact Information #

 * Cristian Falcas <falcas@optymyze.com>
 * [Module Source Code](https://v-git-op-01.optymyze.net/pp_management/abrt)
