############# KEY PAIR ##############

resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb9JgIK9WySpb01zFfo+Y7i5iJhxfNqCABTUikw/9AxKiokO5IOhRq5I0ehJopJn6uOCirSKaJt6V2EIzNtdbS6h478T/AWGRy0/CKqRaH0vTj7IFQORVJV/ItdxY8Nrg/1luSmo5T8FoWKp3JmnzpVQqVoxktXN+wb5ASLCmCsZC+41795sJiky7E7jgPpKoc+X4jP4fF1CzU6PGyRe7gbKDX8AJTZjzi/e9CyJskiVwTINYf1Hcv8IPV6vPknkjJbHXFznpCUY391FgpuOBjKelgFzqvpgP+4iSnDaLNfGAhOPb3IYEXFQTSVU4bICjJZ5L89cW7oRHomVBVReSMOlyLIoAyu+qPL5PGLsz42aHSXhseB/J2oktsGrQUUBI67og33wMu1TJLPbLaJ62vdZkqUvz9Ky97Z4UGrgcF/B0sIW5OpQOmA29sgWMFFdRaaxuvIUVpHECUvaMrq1u0nlBNQfmuBKGGXdq0WjAF6CqzMf903VW/x2Ns8Tc1CwE= adrenaline@BIBINs-MacBook-Pro.local"
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
    user_data = "${path.module}/install-docker.sh"
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