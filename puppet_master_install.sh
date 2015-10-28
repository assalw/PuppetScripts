#!/bin/sh
#
#	Puppet master install en configuration script
#	Author: Wadie Assal
#	Email:	assalw@gmail.com
#
#	Usage: -h <hostname>
#

# Standard values
PUPPET_HOSTNAME=localhost

while getopts h: option
do
        case "${option}"
        in
                h) 		PUPPET_HOSTNAME=${OPTARG};;
				[?]) 	echo 	"Usage: -h <hostname>"
						exit 1
        esac
done

# Install puppet
pkg_add -r puppet

# Add puppet master config file
puppetmasterd --genconfig > /usr/local/etc/puppet/puppet.conf
sed '/certname =/ c\
certname = '${PUPPET_HOSTNAME}'
' /usr/local/etc/puppet/puppet.conf > /usr/local/etc/puppet/tmp.puppet.conf
mv /usr/local/etc/puppet/tmp.puppet.conf /usr/local/etc/puppet/puppet.conf

# Add puppet environments
add_env( ) {
mkdir -p /usr/local/etc/puppet/environments/$1/
echo "[${1}]
modulepath = /usr/local/etc/puppet/environments/${1}/modules
manifest = /usr/local/etc/puppet/environments/${1}/manifests/site.pp
" >> /usr/local/etc/puppet/puppet.conf
}

add_env production
add_env acceptance


# Boot at startup
sed '/sshd_enable/i \
puppetmaster_enable="YES"
' /etc/rc.conf > /etc/tmp.rc.conf
mv /etc/tmp.rc.conf /etc/rc.conf