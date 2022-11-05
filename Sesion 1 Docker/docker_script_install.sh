#!/bin/bash
if command -v apt-get >/dev/null; then
        yes | sudo apt-get update
        sudo apt-get install \
            ca-certificates \
            curl \
            gnupg \
            lsb-release
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update
        yes | sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
        sudo docker run hello-world
elif command -v yum >/dev/null; then
        sudo yum update -y
        yum install yum-utils
        yum clean all
	sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
        sudo yum -y install docker
        sudo service docker start
        sudo usermod -a -G docker ec2-user
        sudo chmod 666 /var/run/docker.sock
else
  echo "I have no Idea what im doing here"
fi
