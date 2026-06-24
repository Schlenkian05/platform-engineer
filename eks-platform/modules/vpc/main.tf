resource "aws_vpc" "main" {

  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "platform-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "public_a" {

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_a
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-a"
  }
}

resource "aws_subnet" "public_b" {

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_b
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-b"
  }
}

resource "aws_subnet" "private_a" {

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_a
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-a"
  }
}

resource "aws_subnet" "private_b" {

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_b
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-b"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "internet" {

  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"

  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_a" {

  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {

  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
}
resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"

  nat_gateway_id = aws_nat_gateway.main.id
}
