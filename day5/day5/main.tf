provider "aws" {
    region "us-east-1"
  
}

module "ec2_instance" {
    source = "./day5/modules/ec2_instance"
    ami_value = "ami-04cb4ca688797756f"
    instance_type_value = "t2.micro"
  
}

module "VPC" {

    source = "./day5/modules/VPC"
    cidr_block_vpc = "10.0.0.0/16"
    cidr_block_public_subnet = "10.0.1.0/24"
    cidr_block_private_subnet = "10.0.2.0/24"
    cidr_block_public_RT = "0.0.0.0/0"
  
}