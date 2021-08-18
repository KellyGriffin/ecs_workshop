cd ~

echo "--------Updating all packages--------"
sudo yum update -y

echo "--------Downloading Tools--------"
sudo yum install wget unzip jq gettext bash-completion -y
sudo pip install --upgrade pip

echo "--------Downloading kubectl--------"
sudo curl --silent --location -o /usr/local/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.7/2020-07-08/bin/linux/amd64/kubectl
sudo chmod +x /usr/local/bin/kubectl

echo "---------eksctl----------"
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

echo "--------Removing unneeded docker images--------"
docker images -q | xargs docker rmi || true

echo "--------Upgrading AWS CLI--------" 
pip install awscli --upgrade
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc

echo "--------Auto completion----------"
kubectl completion bash >>  ~/.bash_completion
. /etc/profile.d/bash_completion.sh
. ~/.bash_completion

echo "--------Verification--------"
echo "kubectl"
kubectl version --short --client

echo "eksctl"
eksctl version
