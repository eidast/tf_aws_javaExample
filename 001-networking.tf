resource "aws_vpc" "main" {
  cidr_block            = "${var.cidr_block_main}"
  enable_dns_hostnames  = true

  tags {
    Name        = "main"
    Description = "In this VPC is the home of tf_aws_javaExample project"    
  }
}

resource "aws_subnet" "subnet_admin" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.cidr_block_subnet_admin}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  map_public_ip_on_launch = true

  tags {
    Name = "main_subnet_a"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.cidr_block_subnet_a}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"

  map_public_ip_on_launch = true

  tags {
    Name = "main_subnet_a"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.cidr_block_subnet_b}"
  availability_zone = "${data.aws_availability_zones.available.names[2]}"

  map_public_ip_on_launch = true

  tags {
    Name = "main_subnet_a"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "main_gateway"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = "${aws_vpc.main.id}"

  route {
   cidr_block = "${var.cidr_world}"
   gateway_id = "${aws_internet_gateway.gateway.id}"
  }

 tags {
   Name = "Route Table Main_Gateway"
 }
}

resource "aws_route_table_association" "rt_association_a" {
  subnet_id = "${aws_subnet.subnet_a.id}"
  route_table_id = "${aws_route_table.route_table.id}"
}

resource "aws_route_table_association" "rt_association_b" {
  subnet_id = "${aws_subnet.subnet_b.id}"
  route_table_id = "${aws_route_table.route_table.id}"
}