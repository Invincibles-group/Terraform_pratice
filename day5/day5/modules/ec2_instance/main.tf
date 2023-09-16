resource "ec2_instance" "Instance_2" {
    ami = var.ami_value
    instance_type = var.instance_type_value
}