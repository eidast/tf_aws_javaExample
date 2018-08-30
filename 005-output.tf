output "jenkins_public_ip" {
  description = "Public IP address for Jenkins Server"
  value       = "${aws_instance.jenkins.public_ip}"
}

output "jenkins_private_ip" {
  description = "Private IP address for Jenkins Server"
  value       = "${aws_instance.jenkins.private_ip}"
}

output "ansible_public_ip" {
  description = "Public IP address for Ansible Server"
  value       = "${aws_instance.ansible.public_ip}"
}