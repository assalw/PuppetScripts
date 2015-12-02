# PuppetScripts
Collection of scripts for managing a Puppet environment.

#### puppet_kick.py
Puppet kick all nodes registered with the Puppet master without LDAP. This is an alternative for "puppet kick --all".
The hostname information is extracted from "puppet cert --list --all".

#### puppet_agent_install.sh
Install en configure a puppet agent on an FreeBSD machine.

- Usage: **-e \<environment\> -m \<puppetmaster_hostname\>**

#### puppet_master_install.sh
Install en configure a puppet master on an FreeBSD machine.

- Usage: **-h \<puppetmaster_hostname\>**
