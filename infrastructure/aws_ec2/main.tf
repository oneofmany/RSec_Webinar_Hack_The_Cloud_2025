# Configure the AWS Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # You can change this to your desired AWS region
}

# Use a data source to get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["137112412989"] # This is the AWS account ID for Amazon Linux 2 AMI
  
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }
}

# Create the EC2 instance resource
resource "aws_instance" "example_instance" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro" # Using a free tier eligible instance type
  
  tags = {
    Name = "My-Terraform-EC2-Instance"
  }
}
