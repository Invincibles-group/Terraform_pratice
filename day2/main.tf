
#Step 1 Create VPC
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "main"
  }
}

#Step 2  Create a public subnet
resource "aws_subnet" "PublicSubnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}

#Step 3 Create a private Subnet
resource "aws_subnet" "PrivateSubnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Main"
  }
}
#Step 5 Create IGW
resource "aws_internet_gateway" "igw_1" {
  vpc_id              = aws_vpc.main.id
}

# Step 5 Route table for Public Subnet
resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.main.id
  route{
	cidr_block = "0.0.0.0/0"
	gateway_id = aws_internet_gateway.igw_1.id
	
  }
}
# Step 6 Route table association for Public Subnet
resource "aws_route_table_association" "PublicRTassociation"{

	subnet_id = aws_subnet.PublicSubnet.id
	route_table_id = aws_route_table.PublicRT.id

}
