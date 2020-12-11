resource "aws_vpc" "MyVPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "MyVPC"
  }
}

resource "aws_internet_gateway" "MyIGW" {
  vpc_id = aws_vpc.MyVPC.id

  tags = {
    Name = "MyIGW"
  }
}

resource "aws_subnet" "MyVPC-PubSN" {
  vpc_id     = aws_vpc.MyVPC.id
  availability_zone = "us-east-2a"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "MyVPC-PubSN"
  }
}

resource "aws_subnet" "MyVPC-PriSN" {
  vpc_id     = aws_vpc.MyVPC.id
  availability_zone = "us-east-2b"
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "MyVPC-PriSN"
  }
}

resource "aws_route_table" "MyPubRT" {
  vpc_id = aws_vpc.MyVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MyIGW.id
  }
  tags = {
    Name = "MyPubRT"
  }
}

resource "aws_route_table" "MyPriRT" {
  vpc_id = aws_vpc.MyVPC.id
  tags = {
    Name = "MyPriRT"
  }
}

resource "aws_route_table_association" "MyRTPubAsso" {
  subnet_id      = aws_subnet.MyVPC-PubSN.id
  route_table_id = aws_route_table.MyPubRT.id
}

resource "aws_route_table_association" "MyRTPriAsso" {
  subnet_id      = aws_subnet.MyVPC-PriSN.id
  route_table_id = aws_route_table.MyPriRT.id
}

