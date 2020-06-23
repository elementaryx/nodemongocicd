#! /bin/bash
yum install httpd -y
sudo service httpd restart
sudo chkconfig httpd on