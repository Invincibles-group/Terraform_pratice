variable "ami_value" {
    description="ami value for instance"
    default = "ami-053b0d53c279acc90"
}
variable "instance_type" {
    description = "Ec2 instance type"
    default = "t2.micro"
  
}

provider "aws" {
    region="us-east-1"
  
}

resource "aws_vpc" "Terraform_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
    Name = "Terraform_vpc"
  } 
  
}

resource "aws_subnet" "Terraform_public_subnet" {
    vpc_id = aws_vpc.Terraform_vpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
    Name = "Terraform_public_subnet"
  } 
}

resource "aws_internet_gateway" "Terraform_IGW" {
    vpc_id = aws_vpc.Terraform_vpc.id

    tags = {
    Name = "Terraform_IGW"
  }
  
}

resource "aws_route_table" "Terraform_RT" {
    vpc_id = aws_vpc.Terraform_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.Terraform_IGW.id
    }
    
    tags = {
    Name = "Terraform_RT"
  }
  
}

resource "aws_route_table_association" "Terraform_RT_association" {
    subnet_id = aws_subnet.Terraform_public_subnet.id
    route_table_id = aws_route_table.Terraform_RT.id
}

resource "aws_security_group" "Terraform_SG" {
    vpc_id = aws_vpc.Terraform_vpc.id
    ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
   ingress {
    description      = "HTTP from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Terraform_SG"
  }
}

resource "aws_key_pair" "Terraform_KP" {
    key_name = "KP_Terraform"
    public_key = file("~/.ssh/id_rsa.pub")
  
}

resource "aws_instance" "Terraform_instance" {

    ami = var.ami_value
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.Terraform_SG.id]
    subnet_id = aws_subnet.Terraform_public_subnet.id
    key_name = aws_key_pair.Terraform_KP.key_name

  connection {
    type        = "ssh"
    user        = "ubuntu"  # Replace with the appropriate username for your EC2 instance
    private_key = file("~/.ssh/id_rsa")  # Replace with the path to your private key
    host        = self.public_ip
  }

   # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "app.py"  # Replace with the path to your local file
    destination = "/home/ubuntu/app.py"  # Replace with the path on the remote instance
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",  # Update package lists (for ubuntu)
      "sudo apt-get install -y python3-pip",  # Example package installation
      "cd /home/ubuntu",
      "sudo pip3 install flask",
      "sudo python3 app.py &",
    ]
  }

}
