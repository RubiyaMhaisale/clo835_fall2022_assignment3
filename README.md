# clo835_fall2022_assignment3

Commands:

<<Disable AWS creds in Cloud9>>
rm -vf ${HOME}/.aws/credentials

aws configure

vi ${HOME}/.aws/credentials
<<Add session token>>

<<Do github pushes for docker images>>

sudo yum -y install jq gettext bash-completion moreutils

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

sudo mv -v /tmp/eksctl /usr/local/bin

eksctl completion bash >> ~/.bash_completion

. /etc/profile.d/bash_completion.sh

. ~/.bash_completion

<<Copy EKS config file>>
eksctl create cluster -f eks_config.yaml

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

docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) 772859080303.dkr.ecr.us-east-1.amazonaws.com
<<docker pull images>>

vi ~/.kube/config
<<change from v1alpha1 to v1beta1>> 

git clone https://github.com/RubiyaMhaisale/clo835_fall2022_assignment3.git
************************************
Task-1:

k get nodes

************************************
Task-2:

cd clo835_fall2022_assignment3/dynamic/
k create -f dynamic_storage_gp2.yaml
k describe storageclass standard
k get sc

************************************
Task-3:

k create ns lab3
k apply -f pvc_mysql.yaml -n lab3
k describe pvc mysql-pvc -n lab3

************************************
Task-4: 

k apply -f mysql_deployment_manifest.yaml -n lab3
k get all -n lab3
k apply -f mysql_clusterip_service.yaml -n lab3
k get all -n lab3
k describe pvc mysql-pvc -n lab3

************************************
Task-6: 

<<get IP of service of mysql, make changes in app deployment file>>
k apply -f app_deployment_manifest.yaml -n lab3
k get all -n lab3
k apply -f app_lb_service.yaml -n lab3 
k get all -n lab3

************************************
Task-7:

k get all -n lab3
k get pods -o wide -n lab3
k delete pod <<mysql-pod>> -n lab3
k get all -n lab3
k get pods -o wide -n lab3
k describe pvc mysql-pvc -n lab3

************************************
Task-8:

cd clo835_fall2022_assignment3/static/
k create ns lab3s
k apply -f static_storage.yaml -n lab3s
k get sc -n lab3s
k apply -f mysql_pv_hostpath.yaml -n lab3s
k get pv -n lab3s
k apply -f mysql_pvc.yaml -n lab3s
k get pvc mysql-s-pvc -n lab3s

k apply -f mysql_deployment_manifest.yaml -n lab3s
k get all -n lab3s
k apply -f mysql_clusterip_service.yaml -n lab3s
k get all -n lab3s
k describe pvc mysql-s-pvc -n lab3s

<<get IP of service of mysql, make changes in app deployment file>>
k apply -f app_deployment_manifest.yaml -n lab3s
k get all -n lab3s
k apply -f app_lb_service.yaml -n lab3s 
k get all -n lab3s

*************************************
Task-9:

k get all -n lab3s
k get pods -o wide -n lab3s
k delete pod <<mysql-pod>> -n lab3s
k get all -n lab3s
k get pods -o wide -n lab3s
k describe pvc mysql-pvc -n lab3s

*************************************
Task-10

cd clo835_fall2022_assignment3/dynamic_config_secrets/
k create ns lab3f
k create -f app-config.yaml -n lab3f
k create secret generic db-user-pass-mspwd --from-file=DBPWD=./DBPWD.txt --from-file=DBUSER=./DBUSER.txt --from-file=MYSQL_ROOT_PASSWORD=./MYSQL_ROOT_PASSWORD.txt -n lab3f

k apply -f pvc_mysql.yaml -n lab3f
k describe pvc mysql-pvc -n lab3f
k apply -f mysql_deployment_manifest.yaml -n lab3f
k get all -n lab3f
k apply -f mysql_clusterip_service.yaml -n lab3f
k get all -n lab3f
k describe pvc mysql-pvcf -n lab3f

<<get IP of service of mysql, make changes in app deployment file>>
k apply -f app_deployment_manifest.yaml -n lab3f
k get all -n lab3f
k apply -f app_lb_service.yaml -n lab3f 
k get all -n lab3f
