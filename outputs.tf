output "dc_public_ip" {
  value = aws_instance.dc.public_ip
}

output "dc_pvt_ip" {
  value = aws_instance.dc.private_ip
}