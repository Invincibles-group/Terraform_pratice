provider "aws" {
    region = "us-east-1"  # Set your desired AWS region
}

resource "aws_instance" "example" {
    ami           = "ami-01c647eace872fc02"  # Specify an appropriate AMI ID
    instance_type = "t2.micro"
    security_groups = [aws_security_group.terraform_SecurityGroup.name]
}


resource "aws_security_group" "terraform_SecurityGroup" {
  name        = "terraform _SecurityGroup"
  description = "terraform _SecurityGroup Allow TLS inbound traffic"
  vpc_id      = "vpc-022edfb54c7e1e762"

  ingress {
    description      = "SSH Port Open"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "terraform _SecurityGroup"
  }
}
