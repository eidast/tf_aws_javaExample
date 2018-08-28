resource "aws_instance" "ansible" {
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t3.micro"

  tags {
    Name = "ansible"
  }
}