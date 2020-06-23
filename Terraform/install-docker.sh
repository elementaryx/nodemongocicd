#! /bin/bash
sudo yum install httpd -y
sudo service httpd restart
sudo chkconfig httpd on