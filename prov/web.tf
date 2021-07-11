provider "aws" {
  region = "ap-south-1"
  profile = "default"
}

resource "aws_instance" "webos1" {
  ami           = "ami-0a9d27a9f4f5c0efc" 
  instance_type = "t2.micro"
  key_name="keyprivatenew"
  tags = {
	      Name="Terraform created Webserver"
	}
  
}

resource "null_resource" "nullremote" {
   connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("/home/vaibhavgole/workspace/keyprivatenew.pem")
    host     =  aws_instance.webos1.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo yum install php -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd --now"
    ]
  }

}

resource "aws_ebs_volume" "create" {
  availability_zone = aws_instance.webos1.availability_zone
  size              = 1

  tags = {
    Name = "HelloWorld"
  }
}


resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdc"
  volume_id   = aws_ebs_volume.create.id
  instance_id = aws_instance.webos1.id
}


resource "null_resource" "nullremote1" {
   connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("/home/vaibhavgole/workspace/keyprivatenew.pem")
    host     =  aws_instance.webos1.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mkfs.ext4 /dev/xvdc",
      "sudo mount /dev/xvdc /var/www/html"
    ]
  }

}

resource "null_resource" "nullremote3" {
   connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("/home/vaibhavgole/workspace/keyprivatenew.pem")
    host     =  aws_instance.webos1.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install git -y",
      "sudo git clone https://github.com/vimallinuxworld13/gitphptest.git /var/www/web"
    ]
  }

}

resource "null_resource" "nullremote4" {
   connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("/home/vaibhavgole/workspace/keyprivatenew.pem")
    host     =  aws_instance.webos1.public_ip
  }
  provisioner "local-exec" {
    command  = "google-chrome http://15.206.168.231/web/index.php"
  }

}




