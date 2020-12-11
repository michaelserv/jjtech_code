provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "Desirevpc" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true
  instance_tenancy = "default"
 enable_dns_support = true
  tags = {
    Name = "Desirevpc"
  }
}
resource "aws_subnet" "Subnet1" {
  vpc_id     = aws_vpc.Desirevpc.id
  availability_zone = "us-east-1a"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Subnet1"
  }
}
resource "aws_subnet" "Subnet2" {
  vpc_id     = aws_vpc.Desirevpc.id
  availability_zone = "us-east-1b"
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Subnet2"
  }
}
resource "aws_internet_gateway" "gwDesire" {
  vpc_id = aws_vpc.Desirevpc.id

  tags = {
    Name = "gwDesire"
  }
}
resource "aws_route_table" "Routetable1" {
  vpc_id = aws_vpc.Desirevpc.id

  tags = {
    Name = "Routetable1"
  }
}

resource "aws_route_table" "Routetable2" {
  vpc_id = aws_vpc.Desirevpc.id

  tags = {
    Name = "Routetable2"
  }
}
resource "aws_route_table_association" "assA" {
  subnet_id      = aws_subnet.Subnet1.id
  route_table_id = aws_route_table.Routetable1.id
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.Subnet2.id
  route_table_id = aws_route_table.Routetable2.id
}
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.Desirevpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["69.138.94.24/32"]
  }

  tags = {
    Name = "allow_tls"
  }
}
resource "aws_instance" "web" {
  ami           = "ami-04d29b6f966df1537"
  subnet_id = aws_subnet.Subnet1.id
  security_groups = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  key_name   = "always_key"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}
resource "aws_route" "routePub" {
  route_table_id = aws_route_table.Routetable1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gwDesire.id
}
