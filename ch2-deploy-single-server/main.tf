provider "aws" {
  region = "us-east-2"
}

resource "aws_launch_configuration" "example" {
  image_id        = "ami-0c55b159cbfafe1f0"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, world" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF   

  #Required for ASG to set create before destroy.

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allows for communication with Web Server to say Hello World."
    from_port        = var.server_port
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    protocol         = "tcp"
    security_groups  = null
    self             = null
    to_port          = var.server_port
  }]
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}

variable "server_port" {
  description = "Port used for HTTP requests."
  type        = number
  default     = 8080
}