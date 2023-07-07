resource "aws_security_group" "sivaram" {
  name        = "apache3"
  description = "this is using for securitygroup"
  vpc_id      = "vpc-035fcb2f3cb9eecc0"

  ingress {
    description = "this is inbound rule"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["103.110.170.85/32"]
  }
  ingress {
    description = "this is inbound rule"
    from_port   = 80
    to_port     = 80
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "siva"
  }
}
resource "aws_instance" "apache" {
  ami                    = "ami-06489866022e12a14"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-0fb122232e90b8015"
  vpc_security_group_ids = [aws_security_group.sivaram.id]
  key_name               = aws_key_pair.demo.id
  user_data              = <<EOF
             #!/bin/bash
             yum update -y
             yum install httpd -y 
             systemctl enable httpd
             systemctl start httpd
       EOF
  tags = {
    Name = "stage-apache"
  }
}
 
