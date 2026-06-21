output "nat_instance_id" {
  value = aws_instance.nat.id
}

output "nat_private_ip" {
  value = aws_instance.nat.private_ip
}

output "nat_public_ip" {
  value = aws_instance.nat.public_ip
}

output "nat_security_group_id" {
  value = aws_security_group.nat_sg.id
}
