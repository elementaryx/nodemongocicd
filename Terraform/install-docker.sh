#! /bin/bash

yum install docker -y
usermod -a -G docker ec2-user
service docker restart
sudo chkconfig docker on