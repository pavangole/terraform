provider "aws"  {

	region = "ap-south-1"
	profile="default"

}


resource "aws_instance" "os1" {
	count = 2
	ami  = "ami-011c99152163a87ae"
	instance_type = "t2.micro"
	key_name = "keyprivatenew"
	tags = {
	    Name = var.instance_name
	}
}


output "myo" {
	value = aws_instance.os1.*.public_ip

}
