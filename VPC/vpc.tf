resource "aws_vpc" "main" {
	cidr_block = var.vpc_cidr
	tags = {
	  Name = "myvpc"
	}
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "myigw"
  }
}


resource "aws_subnet" "main" {
  count = length(var.subnets_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.subnets_cidr,count.index)
  availability_zone = element(var.azs,count.index)

  tags = {
    Name = "Subnet-${count.index + 1}"
  }
}



