variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    default = "10.0.0.0/16"
  
}
variable "availability_zone" {
    description = "Avaliability zones for the Subnets"
    type = list
    default = ["us-east-1a","us-east-1b"]
  
}
variable "private_subnet_cidr" {
    description = "subnets cidr blocks"
    type = list
    default = ["10.0.1.0/24","10.0.2.0/24"]
  
}
