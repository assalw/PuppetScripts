#
# Puppet kick all nodes registered with the Puppet master #
# Author: Wadie Assal
#

import urllib2, string
from commands import *
from threading import Thread

rawstring = getoutput("puppet cert --list --all").split('\n')
opener = urllib2.build_opener(urllib2.HTTPHandler)

# Puppet kick specified host
def puppetkick(host):
    try:
        request = urllib2.Request('https://' + host + ':8139/production/run/no_key', data='{}') 
        request.add_header('Content-Type', 'text/pson')
        request.get_method = lambda: 'PUT'
        opener.open(request)
        print '* Kicking ' + host + ' succeeded.'
    except Exception, e:
        print '* Kicking ' + host + ' failed!'

# Puppet kick all hosts
for line in rawstring :
    host = line.split(' ')[1]
    if 'puppet' in host:
        print 'Skipping Puppet master.'
    elif 'dashboard' in host:
        print 'Skipping Puppet dashbboard.'
    else:
        t = Thread( target=puppetkick , args=(host,) ) 
        t.start()
        print 'Kicking: ' + host
