resource "aws_instance" "webserver" {
  ami           = var.ami_id
  subnet_id      = aws_subnet.MyVPC-PubSN.id
  associate_public_ip_address = true
  security_groups = [aws_security_group.allow_ssh.id]
  instance_type = var.instance_type
  key_name   = var.key_name
  tags = {
    Name = "webserver"
  }
}
