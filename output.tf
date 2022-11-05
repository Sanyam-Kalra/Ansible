output "private-ip" {
  value = aws_instance.Haproxy_Head.private_ip

}

output "nat" {
  value = aws_nat_gateway.nat.id
}

output "private-ip-backend1" {
  value = "${aws_instance.Haproxy_backend1.*.private_ip}"
}


output "private-ip-Haproxy_backend2" {
  value = "${aws_instance.Haproxy_backend2.*.private_ip}"
}

output "public_config_ec2" {
  value = aws_instance.config_ec2.public_ip
  
}
