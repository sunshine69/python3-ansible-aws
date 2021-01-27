#!/bin/sh

if [ ! -f kubectl ]; then
	curl -L -o kubectl  "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
fi

chmod +x kubectl

if [ ! -f helm ] || [ ! -f helm-v3.5.0-linux-amd64.tar.gz ]; then
    wget https://get.helm.sh/helm-v3.5.0-linux-amd64.tar.gz
else
    echo "helm binary exists in current dir so bypassing the update"
fi

tar xf helm-v3.5.0-linux-amd64.tar.gz
mv linux-amd64/helm .

chmod +x helm

rm -rf linux-amd64

if [ ! -f powershell-7.1.0-linux-x64.tar.gz ]; then
    curl -L -o powershell-7.1.0-linux-x64.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.1.0/powershell-7.1.0-linux-x64.tar.gz
fi

if [ ! -f docker-19.03.12.tgz ]; then
	curl -o docker-19.03.12.tgz 'https://download.docker.com/linux/static/stable/x86_64/docker-19.03.12.tgz'
fi

tar xf docker-19.03.12.tgz

