#!/bin/bash
CENTOS_VERSION=`cat /etc/centos-release | sed 's/[^0-9\.]*//g' | cut -d "." -f1`
rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-${CENTOS_VERSION}.noarch.rpm
yum install puppet-agent-1.3.6 -y

# Remove certname so the system will use host FQDN
sed -i '/certname =/d' /etc/puppetlabs/puppet/puppet.conf

# add /opt/puppet/bin/ to the path of all users
echo "export PATH=$PATH:/opt/puppetlabs/puppet/bin/" >> /etc/profile
export PATH=$PATH:/opt/puppetlabs/puppet/bin/
