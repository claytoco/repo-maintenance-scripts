#!/bin/bash
cd /var/www/html/pub/centos
#lftp -e 'open http://mirror.internode.on.net/pub/centos/ && mirror -c --delete 7.2.1511 && exit'
#lftp -e 'open http://mirror.internode.on.net/pub/centos/ && mirror -c --delete 6.8 && exit'
lftp -e 'open http://mirror.internode.on.net/pub/centos/ && mirror -c --delete 7.3.1611 && exit'
cd /var/www/html/pub/epel/7/
rsync -vtr --progress --delete --exclude debug/ rsync://uberglobalmirror.com/epel/7/x86_64/ x86_64/
