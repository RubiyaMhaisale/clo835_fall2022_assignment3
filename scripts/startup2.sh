#!/bin/sh

aws eks update-kubeconfig --name clo835 --region us-east-1 

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

rm -f ./kubectl

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

sudo ./aws/install

kubectl completion bash >> ~/.bash_completion

. /etc/profile.d/bash_completion.sh

. ~/.bash_completion

echo "alias k=kubectl" >> ~/.bashrc

. ~/.bashrc

echo 'export LBC_VERSION="v2.4.1"' >> ~/.bash_profile

echo 'export LBC_CHART_VERSION="1.4.1"' >> ~/.bash_profile

. ~/.bash_profile
