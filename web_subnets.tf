# This file represets web private subnets for eu-west-1a and eu-west-1b AZs.
# There are also route tables and route table associations for web private subnets.  
# Hosts in private subnets don't have any public ips and use only outbound traffic through NAT gateways.

resource "aws_subnet" "web_private" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.cidr_web
  availability_zone = "eu-west-1a"

  tags = {
    Name = "web_private"
  }
} 


resource "aws_route_table" "private_web_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my_nat1_gw.id
  }  

  tags = {
    Name = "private_web_table"
  }
}

resource "aws_eip" "nat1_eip"{
  vpc        = true
  depends_on = [aws_internet_gateway.my_igw]
  
  tags = {
    Name = "nat1_eip"
  }
}


resource "aws_nat_gateway" "my_nat1_gw"{ 
  allocation_id = aws_eip.nat1_eip.id
  subnet_id     = aws_subnet.alb_public1.id

  tags = {
    Name = "my_nat1_gw"
  }
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.web_private.id
  route_table_id = aws_route_table.private_web_table.id
 }





