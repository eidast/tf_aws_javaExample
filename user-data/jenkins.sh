#!/bin/bash

sudo rpm -i https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum update -y

aws s3 cp s3://tf-aws-configuration-bucket/master_server_id_rsa.pub /home/ec2-user/.ssh/

cat /home/ec2-user/.ssh/master_server_id_rsa.pub >> /home/ec2-user/.ssh/authorized_keys