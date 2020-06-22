variable "ami" {
  description = "ami id"
  default = "ami-0e34e7b9ca0ace12d"
}

variable "type" {
  description = "Instance type"
  default = "t2.micro"
}

variable "AWS_ACCESS_KEY_ID" {
  description = "access key"
  type = "string"
  
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "secret key"
   type = "string"
  
}


