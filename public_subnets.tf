# Creating 2 public subnets in different AZs for ALB.
# Also creating internet gateway and route tables with route table associations.

resource "aws_subnet" "alb_public1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.cidr_public1
  availability_zone = "eu-west-1a"

  tags = {
    Name = "alb_public1"
  }
}

resource "aws_subnet" "alb_public2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.cidr_public2
  availability_zone = "eu-west-1b"

  tags = {
    Name = "alb_public2"
  }
} 

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my_igw"
  }
}

resource "aws_route_table" "public_table"  {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

 tags = {
    Name = "public_table"
  }
}

resource "aws_route_table_association" "public1_assoc" {
  subnet_id      = aws_subnet.alb_public1.id
  route_table_id = aws_route_table.public_table.id
 }

resource "aws_route_table_association" "public2_assoc" {
  subnet_id      = aws_subnet.alb_public2.id
  route_table_id = aws_route_table.public_table.id
 }
