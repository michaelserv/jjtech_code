output "instance_ips" {
  value = aws_instance.webserver.public_ip
}
output "instance_ip" {
  value = aws_instance.webserver.private_ip
}