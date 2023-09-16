
#Step 1 Create VPC
resource "aws_vpc" "VPC_1" {
    
    cidr_block_vpc = "10.0.0.0/16"

    tags = {
    Name = "VPC_1"
  }
}

#Step 3 Create a Public Subnet
resource "aws_subnet" "Public_Subnet" {

    cidr_block_public_subnet = "10.0.1.0/24"
    vpc_id = aws_vpc.VPC_1.id
    tags = {
    Name = "Public_Subnet"
  }
  
}

#Step 3 Create a private Subnet
resource "aws_subnet" "Private_Subnet" {

    cidr_block_private_subnet = "10.0.2.0/24"
    vpc_id = aws_vpc.VPC_1.id
    tags = {
    Name = "Private_Subnet"
  }
  
}

#Step 5 Create IGW
resource "aws_internet_gateway" "IGW_1" {
    vpc_id = aws_vpc.VPC_1.id

    tags = {
    Name = "IGW_1"
  }
  
}

# Step 5 Route table for Public Subnet
resource "aws_route_table" "PublicRT" {
    vpc_id = aws_vpc.VPC_1.id
    route {
        cidr_block_public_RT = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW_1.id
    }
}


# Step 6 Route table association for Public Subnet
resource "aws_route_table_association" "PublicRTassociation" {

    subnet_id = aws_subnet.Public_Subnet.id
    route_table_id = aws_route_table.PublicRT.id
  
}