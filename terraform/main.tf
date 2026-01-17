terraform {
  backend "s3" {
    bucket = "creditflowemi-terraform-state"
    key    = "prod/terraform.tfstate"
    region = "ap-south-1"
  }
}


provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "emi_sg" {
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = ["103.120.248.84/32"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["103.120.248.84/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    # cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = ["103.120.248.84/32"]
  }
}

resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  
  vpc_security_group_ids = [aws_security_group.emi_sg.id]

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    encrypted = true
  }
 
  user_data = <<-EOF
              #!/bin/bash
              
              sudo apt-get update -y
              sudo apt-get install -y docker.io git docker-compose
              sudo systemctl start docker
              sudo systemctl enable docker

              cd /home/ubuntu
              git clone https://github.com/Kushintwala1045/CREDITFLOWEMI.git app_code

              cd app_code
              sudo docker-compose up --build -d
              EOF

  tags = {
    Name = "CreditFlow-Production-App"
  }
}