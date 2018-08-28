resource "aws_vpc" "main" {
  cidr_block            = "${var.cidr_block_main}"
  enable_dns_hostnames  = true

  tags {
    Name        = "Main"
    Description = "In this VPC is the home of tf_aws_javaExample project"    
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.cidr_block_subnet_a}"
  availability_zone = "${data.aws_availability_zones.az_available.names[0]}"

  map_public_ip_on_launch = true

  tags {
    Name = "main_subnet_a"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.cidr_block_subnet_a}"
  availability_zone = "${data.aws_availability_zones.az_available.names[1]}"

  map_public_ip_on_launch = true

  tags {
    Name = "main_subnet_a"
  }
}