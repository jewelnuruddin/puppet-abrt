#!/bin/sh
# Once puppetlabs provide CentOS8, we will dissolve this script
cat /etc/redhat-release | grep -q 8.0
if [ $? == 0 ]; then
sudo rpm -ivh https://yum.puppetlabs.com/puppet-release-el-8.noarch.rpm
sudo yum -y install puppet
fi
