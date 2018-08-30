#!/bin/bash 
# Update all packages 
sudo rpm -i https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum update -y
sudo yum install ansible -y

aws s3 cp s3://tf-aws-configuration-bucket/master_server_id_rsa /home/ec2-user/.ssh/
aws s3 cp s3://tf-aws-configuration-bucket/master_server_id_rsa.pub /home/ec2-user/.ssh/

sudo chown ec2-user.ec2-user /home/ec2-user/.ssh/master_server_id_rsa*
sudo chmod 400 /home/ec2-user/.ssh/master_server_id_rsa