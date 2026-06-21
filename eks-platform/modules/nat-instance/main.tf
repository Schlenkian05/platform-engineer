###################################
# Amazon Linux AMI
###################################

data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }
}

###################################
# Security Group
###################################

resource "aws_security_group" "nat_sg" {

  name        = "nat-instance-sg"
  description = "NAT Instance Security Group"
  vpc_id      = var.vpc_id

  ingress {

    from_port = 0
    to_port   = 65535

    protocol = "tcp"

    cidr_blocks = [
      "10.0.0.0/16"
    ]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "nat-instance-sg"
  }
}

###################################
# NAT Instance
###################################

resource "aws_instance" "nat" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  subnet_id = var.public_subnet_id

  associate_public_ip_address = true

  source_dest_check = false

  vpc_security_group_ids = [
    aws_security_group.nat_sg.id
  ]

  tags = {
    Name = "nat-instance"
  }
}

###################################
# Private Route
###################################

resource "aws_route" "private_default_route" {

  route_table_id = var.private_route_table_id

  destination_cidr_block = "0.0.0.0/0"

  network_interface_id = aws_instance.nat.primary_network_interface_id

}
