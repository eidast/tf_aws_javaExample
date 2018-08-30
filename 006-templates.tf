data "template_file" "ansible-hosts" {
  template = "${file("templates/ansible-hosts.tpl")}"

  vars {
    jenkins_private_ip = "${aws_instance.jenkins.private_ip}"
  }
}

data "template_file" "ssh-config" {
  template = "${file("templates/ssh-config.tpl")}"

  vars {
    jenkins_private_ip = "${aws_instance.jenkins.private_ip}"
  }
}

resource "null_resource" "export_ansible_templates" {
  provisioner "local-exec" {
    command = "echo '${data.template_file.ansible-hosts.rendered}' > ./ansible/hosts"
  }

  provisioner "local-exec" {
    command = "echo '${data.template_file.ssh-config.rendered}' > ./credentials/config"
  }

  depends_on = ["aws_instance.ansible"]
}