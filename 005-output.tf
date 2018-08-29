output "jenkins_ip" {
  description = "IP address for Jenkins Server"
  value       = "${aws_instance.jenkins.public_ip}"
}

output "ansible_ip" {
  description = "IP address for Ansible Server"
  value       = "${aws_instance.ansible.public_ip}"
}
