# Creating Security group for hosts in web subnet.
# For security purposes ssh access to the hosts in web(private) subnet is limited only from Bastion hosts.
# Hosts in web subnet don't have any public ips and use only outbound traffic through NAT gateways.

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "SG rules for hosts in web subnets"   
  vpc_id      = aws_vpc.my_vpc.id        

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    ="-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "web_sg"
  }
}

