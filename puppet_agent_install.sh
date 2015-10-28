#!/bin/sh
#
#	Puppet agent install en configuration script
#	Author: Wadie Assal
#	Email:	assalw@gmail.com
#
#	Usage: -e <environment> -m <puppetmaster>
#

# Standard values
PUPPET_ENV=production
PUPPET_MASTER=localhost

while getopts e:m: option
do
        case "${option}"
        in
                e) 		PUPPET_ENV=${OPTARG};;
				m) 		PUPPET_MASTER=${OPTARG};;
				[?]) 	echo 	"Usage: -e <environment> -m <puppetmaster>"
						exit 1
        esac
done

# Install puppet
pkg_add -r puppet

# Add puppet agent config file
echo "[main]
server = ${PUPPET_MASTER}
environment = ${PUPPET_ENV}
listen = true" > /usr/local/etc/puppet/puppet.conf

# Boot at startup
sed '/sshd_enable/i \
puppet_enable="YES"
' /etc/rc.conf > /etc/tmp.rc.conf
mv /etc/tmp.rc.conf /etc/rc.conf


