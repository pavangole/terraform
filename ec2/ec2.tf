
#Which provider you want to get resources
provider "aws"  { 
  #In which region, you want resources to be available
  region = "ap-south-1"
  #Give terraform credentials to go to the provider
  profile="default"
}

#Creating one ec2-instance
resource "aws_instance" "os1" {

  ami  = "ami-0a9d27a9f4f5c0efc"
  instance_type = "t2.micro"
  tags = {
      Name = "First Instance"
  }
}

#Creating one volume to attach to ec2
resource "aws_ebs_volume" "example" {
  availability_zone = aws_instance.os1.availability_zone
  size              = 1

  tags = {
    Name = "HelloWorld"
  }
}

#Attaching the volume to the instance we created earlier
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.os1.id
}
