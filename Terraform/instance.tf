############# KEY PAIR ##############

resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDpAak8yPpzvD0Wj5TKNA/x4aSFpTqEQZSLz4lFWj+VSI6X4EdcatgglbWNWaAqx1Xl02pI/p601AawHUKSdmMTeZgfSMlpGiC7jduGPDZCKTT2GWASKGvNNP+4zR0NkuV/yVf9BLIXPvfpLQ7yLXJ8fd4HZn6B6fEFo4CrUBLIwxsS2MxKEvnMkIjG4Z39m3xdwe4UL3NtNoj3Sd5HbDRV+QnZLRhujd3aWBzVauYpY4wq7VtVOkHaHv4VoEg1iBV0iUK80b47xullr2au6GI0bD/1TeBtFCeCZPuIasjOrlKB8ywFI/iLLrWtrSS4bVGMQglC8pF5LajZftVSeET ec2-user@ip-172-31-40-93.ap-south-1.compute.internal"
}

############# SECURITY GROUP WEBSERVER ##############

resource "aws_security_group" "webserver" {
  
  name = "webserver"
  description = "allows 80 from all"

  ingress {
      cidr_blocks = ["0.0.0.0/0"]
      from_port = 80
      to_port = 80
      protocol = "tcp"
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
      Name = "webserver"
  }
}

############# SECURITY GROUP SSH ##############

resource "aws_security_group" "ssh" {
  
  name = "ssh"
  description = "allows 22 from all"

  ingress {
      cidr_blocks = ["0.0.0.0/0"]
      from_port = 22
      to_port = 22
      protocol = "tcp"
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
      Name = "ssh"
  }
}


############# EC2 LAUNCH ##############

resource "aws_instance" "webserver" {

    ami = var.ami
    instance_type = var.type
    key_name = "mykey"
    availability_zone  = "ap-south-1a"
    user_data = file("install-httpd.sh")
    vpc_security_group_ids = ["${aws_security_group.webserver.id}",
                               "${aws_security_group.ssh.id}"]
    tags = {
        Name = "webserver"
  }
}

########## OUTPUT IP ###########

output "ip"{
value= "${aws_instance.webserver.public_ip}"
}