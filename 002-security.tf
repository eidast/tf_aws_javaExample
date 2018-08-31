// Create role for EC2 instances
resource "aws_iam_role" "ec2_role" {
  name        = "EC2_Role"
  description = "Politica para los EC2"

  assume_role_policy = <<EOP
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOP
}

// Read only for S3 buckets to instances
resource "aws_iam_policy_attachment" "s3_ro_attach" {
  name       = "S3_ReadOnly"
  roles      = ["${aws_iam_role.ec2_role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

// Allow to EC2 instances send email using Amazon SES
resource "aws_iam_policy_attachment" "ses_rw_attach" {
  name       = "SES_FullAccess"
  roles      = ["${aws_iam_role.ec2_role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSESFullAccess"
}

// 
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2_Profile"
  role = "${aws_iam_role.ec2_role.name}"
}

// Security Group Definition
resource "aws_security_group" "general" {
  name = "General Security Group"
  description = "Allow Inbound/Outbound Traffic for All Servers"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.cidr_world}"]
  }

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["${var.cidr_block_main}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["${var.cidr_world}"]
  }
}

resource "aws_security_group" "application_servers" {
  name = "Application Server Security Group"
  description = "Allow Inbound/Outbound Traffic for Application Servers"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web_servers" {
  name = "Web Server Security Group"
  description = "Allow Inbound/Outbound Traffic for Web Servers"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

/*
resource "aws_security_group_rule" "internal_traffic" {
  type = "ingress"
  from_port = 0
  to_port   = 65535
  protocol = "-1"
  cidr_blocks = ["10.0.0.0/16"]
}
*/