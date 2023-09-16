provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "Instance1" {
    ami = var.ami_value
    instance_type = var.instance_type_value
    tags = {
    Name = "Instance1"
  }
  
}