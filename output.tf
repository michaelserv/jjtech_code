output "public_ips" {
  value = aws_instance.webserver.public_ip
}

output "private_ips1" {
  value = aws_instance.webserver.private_ip
}
