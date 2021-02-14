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
              nohup busybox httpd -f -p ${var.server_port} &
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
  from_port = var.server_port
  ipv6_cidr_blocks = null
  prefix_list_ids = null
  protocol = "tcp"
  security_groups = null
  self = null
  to_port = var.server_port
} ]
} 

variable "server_port" {
  description = "Port used for HTTP requests."
  type = number
  default = 8080
}

output "public_ip" {
  value = aws_instance.example.public_ip
  description = "Gives public IP address of instance."
  sensitive = false
}