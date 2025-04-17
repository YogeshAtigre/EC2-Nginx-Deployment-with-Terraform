provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "skill_test_3_sg" {
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    from_port = 80
    to_port = 80
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "nginx_test_server" {
  
  ami = "ami-042e8287309f5df03"
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.skill_test_3_sg.id]

user_data = <<-EOF
#!/bin/bash
apt update -y
apt install nginx -y
echo "Welcome to the Terraform-managed Nginx Server on Ubuntu" > /var/www/html/index.html
systemctl start nginx
systemctl enable nginx
EOF

    tags = {
        Name = "Terraform-skill-test-3"
    }

}