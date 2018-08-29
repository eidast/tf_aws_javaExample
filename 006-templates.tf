data "template_file" "ansible-hosts" {
  template = "${file("templates/ansible-hosts.tpl")}"

  vars {
    jenkins_ip = "${aws_instance.jenkins.public_ip}"
    ansible_ip = "${aws_instance.ansible.public_ip}"
  }
}