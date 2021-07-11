provider "aws"  {

	region = "ap-south-1"
	profile="default"

}


resource "aws_instance" "os1" {

	ami  = "ami-0a9d27a9f4f5c0efc"
	instance_type = "t2.micro"
	tags = {
	    Name = "my first TF PslfjsldfjavanOS"
	}
}
