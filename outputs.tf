output "dc_public_ip" {
  value = aws_instance.dc.public_ip
}

output "dc_pvt_ip" {
  value = aws_instance.dc.private_ip
}

output "dc_sg_id" {
  value = aws_security_group.dc.id
}