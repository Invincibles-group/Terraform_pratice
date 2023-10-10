resource "aws_vpc" "aka-vpc" {
    cidr_block = var.vpc_cidr
    tags ={
        name= "aka-vpc"
    }
}

resource "aws_subnet" "aka-subnets" {
    vpc_id = aws_vpc.aka-vpc.id
    count = length(var.private_subnet_cidr)
    cidr_block = element(var.private_subnet_cidr,count.index)
    availability_zone = element(var.availability_zone,count.index)
    tags = {
    Name = "aka-private-Subnet-${count.index+1}"
  }  
}

resource "aws_internet_gateway" "aka-IGW" {
    vpc_id = aws_vpc.aka-vpc.id
    tags ={
        name = "aka-IGW"
    }
}

resource "aws_route_table" "aka-RT" {
    vpc_id = aws_vpc.aka-vpc.id
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.aka-IGW.id
    }
    tags ={
        name = "aka-RT"
    }
  
}

resource "aws_route_table_association" "aka-RTA" {
    route_table_id = aws_route_table.aka-RT.id
    count = length(var.private_subnet_cidr)
    subnet_id = element(aws_subnet.aka-subnets.*.id,count.index)
}
