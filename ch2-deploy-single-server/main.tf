provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, world" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF   

  tags = {
    "Name" = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

ingress = [ {
  cidr_blocks = [ "0.0.0.0/0" ]
  description = "Allows for communication with Web Server to say Hello World."
  from_port = 8080
  ipv6_cidr_blocks = null
  prefix_list_ids = null
  protocol = "tcp"
  security_groups = null
  self = null
  to_port = 8080
} ]
} 