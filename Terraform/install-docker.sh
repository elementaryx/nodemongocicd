
#!/bin/bash
sudo su
sudo yum -y install docker
sudo usermod -a -G docker ec2-user
sudo service docker restart
sudo chkconfig docker on
                    