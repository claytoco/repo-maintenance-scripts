#!/bin/bash
#Post-Install script for repo.internal.gov
#
#  ### Assumptions ###
#
# The software packages in the manual install is set to "web server"
# it is unable to be kickstarted from a script. 
# the mirror is "mirror.internode.on.net", it can be changed to the local regional mirror or "sed" section commented out. 
# Firewalld is aleady indstalled
#
#  ### ENDE ###
## STARTEN 
echo "### Start Of Script ###" 
sed -i s/^#baseurl/baseurl/g /etc/yum.repos.d/CentOS-Base.repo
sed -i s/^mirror/#mirror/g /etc/yum.repos.d/CentOS-Base.repo
sed -i s_mirror.centos.org_mirror.internode.on.net/pub_g /etc/yum.repos.d/CentOS-Base.repo 
## PATCH
echo "### The First Updates ###"
yum clean all
sudo yum update -y
## ENABLE
echo "### setting up the services and firewall ###"
systemctl enable httpd.service
firewall-cmd --permanent --add-service=http
## Change
echo "### Last Minute Adjustments ###"
cp /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.orig 
sed -i s/^/#/g /etc/httpd/conf.d/welcome.conf
cp /etc/httpd/conf.d/autoindex.conf /etc/httpd/conf.d/autoindex.conf.orig
sed -i s/^IndexOptions.*$/IndexOptions\ FancyIndexing\ HTMLTable\ VersionSort\ NameWidth=*\ DescriptionWidth=*\ IgnoreCase\ +SuppressHTMLPreamble/g /etc/httpd/conf.d/autoindex.conf
systemctl restart httpd.service
systemctl reload firewalld.service
chcon -R -t httpd_sys_content_t /var/www/html/

echo "#### ##### ####"
echo "#### Done! ####"
echo "#### ##### ####"
## ENDE
