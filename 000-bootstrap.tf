
variable "region" {
    type    = "string"
    default = "us-east-1"
}

variable "ami" {
    type    = "string"
    default = ""
}

variable "cidr_block_main" {
    type    = "string"
    default = "10.0.0.0/16"
}

variable "cidr_block_subnet_a" {
    type    = "string"
    default = "10.0.1.0/24"
}

variable "cidr_block_subnet_b" {
    type    = "string"
    default = "10.0.2.0/24"
}
variable "cidr_world" {
    type = "string"
    default = "0.0.0.0/0"
}

data "aws_availability_zones" "available" {}

data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["410186602215"] # CentOS.org
}

provider "aws" {
  region     = "${var.region}"
}