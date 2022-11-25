#!/bin/sh

sudo yum -y install jq gettext bash-completion moreutils

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

sudo mv -v /tmp/eksctl /usr/local/bin

eksctl completion bash >> ~/.bash_completion

. /etc/profile.d/bash_completion.sh

. ~/.bash_completion

eksctl create cluster -f eks_config.yaml