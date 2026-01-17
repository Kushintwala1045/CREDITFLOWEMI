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
    cidr_blocks = ["103.120.248.84/32"]
  }

  #  INTENTIONAL VULNERABILITY
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
    cidr_blocks = ["103.120.248.84/32"]
  }
}
