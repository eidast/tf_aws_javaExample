#!/bin/bash

cat > tf_aws_javaExample.hosts << EOL
[jenkins]
${jenkins_ip}

[ansible]
${ansible_ip}
EOL