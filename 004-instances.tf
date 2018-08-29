resource "aws_instance" "jenkins" {
  ami             = "${data.aws_ami.amazon.id}"
  instance_type   = "${var.small}"

  subnet_id = "${aws_subnet.subnet_admin.id}"
  security_groups = ["${aws_security_group.general.id}", "${aws_security_group.application_servers.id}"]
  key_name = "${var.project_key_pair}"

  tags {
    Name = "jenkins server"
    Type = "control server"
  }
}

resource "aws_instance" "ansible" {
  ami           = "${data.aws_ami.amazon.id}"
  instance_type = "${var.nano}"

  subnet_id = "${aws_subnet.subnet_admin.id}"
  security_groups = ["${aws_security_group.general.id}"]
  key_name = "${var.project_key_pair}"

  iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.id}"

	tags {
		Name = "ansible master server"
		Type = "control server"    
	}

  user_data = "${file("user-data/ansible.sh")}"

  depends_on = [
    "aws_s3_bucket.config",
    "aws_s3_bucket_object.master_server_id_rsa",
    "aws_instance.jenkins"
  ]
}

/*
resource "aws_instance" "kubernetes_master_a" {
  ami             = "${data.aws_ami.centos.id}"
  instance_type   = "${var.small}"

  subnet_id = "${aws_subnet.subnet_a.id}"
  security_groups = ["${aws_security_group.general.id}", "${aws_security_group.application_servers}"]
  key_name = "${var.project_key_pair}"

  tags {
    Name = "kubernetes master"
    Type = "control server"
  }
}

resource "aws_instance" "kubernetes_node_a" {
  ami             = "${data.aws_ami.centos.id}"
  instance_type   = "${var.small}"

  subnet_id = "${aws_subnet.subnet_a.id}"
  security_groups = ["${aws_security_group.general.id}", "${aws_security_group.application_servers}"]
  key_name = "${var.project_key_pair}"

  tags {
    Name = "kubernetes master"
    Type = "control server"
  }
}

resource "aws_instance" "kubernetes_master_b" {
  ami             = "${data.aws_ami.centos.id}"
  instance_type   = "${var.small}"

  subnet_id = "${aws_subnet.subnet_b.id}"
  security_groups = ["${aws_security_group.general.id}", "${aws_security_group.application_servers}"]
  key_name = "${var.project_key_pair}"

  tags {
    Name = "kubernetes master"
    Type = "control server"
  }
}

resource "aws_instance" "kubernetes_node_b" {
  ami             = "${data.aws_ami.centos.id}"
  instance_type   = "${var.small}"

  subnet_id = "${aws_subnet.subnet_b.id}"
  security_groups = ["${aws_security_group.general.id}", "${aws_security_group.application_servers}"]
  key_name = "${var.project_key_pair}"

  tags {
    Name = "kubernetes master"
    Type = "control server"
  }
}
*/