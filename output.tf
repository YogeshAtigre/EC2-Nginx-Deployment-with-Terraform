output "instance publicip" {
  description = "Public IP of the EC2 instance for Skill Test 3"
  value = aws_instance.nginx_test_server.public_ip
}