# Terraform state will be stored in S3
 terraform {
 backend "s3" {
   bucket = "task4.website"
   key    = "terraform.tfstate"
   region = "eu-west-1"
 }
}

# Use AWS Terraform provider
provider "aws" {
  region = "eu-central-1"
}

# Create EC2 instance
resource "aws_instance" "default" {
  ami           = "ami-0ba441bdd9e494102"
  instance_type = "t2.micro"
# resource "aws_instance" "default" {
#  ami                    = var.ami
#  count                  = var.instance_count
#  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.default.id]
  source_dest_check      = false
#  instance_type          = var.instance_type

  tags = {
    Name = "terraform-default"
  }
}

# Create Security Group for EC2
resource "aws_security_group" "default" {
  name = "terraform-default-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
