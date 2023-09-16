provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
    source = "./day4/modules/ec2_instance"
    ami_value = "ami-04cb4ca688797756f"
    instance_type_value = "t2.micro"
    
}
