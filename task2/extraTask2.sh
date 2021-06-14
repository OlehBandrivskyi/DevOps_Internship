#!/bin/bash
#sudo -i

yum -y update 
yum -y install httpd

echo "<html><center><h1>Hello world</h1></center>" > /var/www/html/index.html
sed -z 's/\n/<br\/>/g' /etc/os-release >>  /var/www/html/index.html
echo "</html>" >> /var/www/html/index.html

service httpd start
chkconfig httpd on