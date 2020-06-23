#! /bin/bash
sudo yum update -y
sudo yum install docker -y
sudo usermod -a -G docker ec2-user
sudo service docker restart
sudo chkconfig docker on