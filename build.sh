#!/bin/bash -e

for base_image in ubuntu:latest alpine:latest amd64/clearlinux:latest; do
    docker pull $base_image
done

export ANSIBLE_VERSION="2.9.1"

build_clearlinux() {
docker build --build-arg ANSIBLE_VERSION=$ANSIBLE_VERSION -t xvtsolutions/clearlinux-python3-aws-ansible:$ANSIBLE_VERSION -f Dockerfile.clearlinux .
docker tag xvtsolutions/clearlinux-python3-aws-ansible:$ANSIBLE_VERSION xvtsolutions/clearlinux-python3-aws-ansible:latest
docker push xvtsolutions/clearlinux-python3-aws-ansible:$ANSIBLE_VERSION
docker push xvtsolutions/clearlinux-python3-aws-ansible:latest
#echo "Not supported"
#return
}

build_alpine() {
docker build --build-arg ANSIBLE_VERSION=$ANSIBLE_VERSION -t xvtsolutions/alpine-python3-aws-ansible:$ANSIBLE_VERSION -f Dockerfile.alpine .
docker tag xvtsolutions/alpine-python3-aws-ansible:$ANSIBLE_VERSION xvtsolutions/alpine-python3-aws-ansible:latest
docker push xvtsolutions/alpine-python3-aws-ansible:$ANSIBLE_VERSION
docker push xvtsolutions/alpine-python3-aws-ansible:latest
}

build_clearlinux_python2() {
#docker build --build-arg ANSIBLE_VERSION=$ANSIBLE_VERSION -t xvtsolutions/clearlinux-python2-aws-ansible:$ANSIBLE_VERSION -f Dockerfile-python2.clearlinux .
#docker tag xvtsolutions/clearlinux-python2-aws-ansible:$ANSIBLE_VERSION xvtsolutions/clearlinux-python2-aws-ansible:latest
#docker push xvtsolutions/clearlinux-python2-aws-ansible:$ANSIBLE_VERSION
#docker push xvtsolutions/clearlinux-python2-aws-ansible:latest
echo "Not supported"
return
}

build_alpine_python2() {
#docker build --build-arg ANSIBLE_VERSION=$ANSIBLE_VERSION -t xvtsolutions/alpine-python2-aws-ansible:$ANSIBLE_VERSION -f Dockerfile-python2.alpine .
#docker tag xvtsolutions/alpine-python2-aws-ansible:$ANSIBLE_VERSION xvtsolutions/alpine-python2-aws-ansible:latest
#docker push xvtsolutions/alpine-python2-aws-ansible:$ANSIBLE_VERSION
#docker push xvtsolutions/alpine-python2-aws-ansible:latest
echo "Not supported"
return
}

build_ubuntu() {
docker build --build-arg ANSIBLE_VERSION=$ANSIBLE_VERSION -t xvtsolutions/python3-aws-ansible:$ANSIBLE_VERSION -f Dockerfile .
docker tag xvtsolutions/python3-aws-ansible:$ANSIBLE_VERSION xvtsolutions/python3-aws-ansible:latest
docker push xvtsolutions/python3-aws-ansible:$ANSIBLE_VERSION
docker push xvtsolutions/python3-aws-ansible:latest
}

build_ubuntu_python2() {
docker build --build-arg ANSIBLE_VERSION=$ANSIBLE_VERSION -t xvtsolutions/python2-aws-ansible:$ANSIBLE_VERSION -f Dockerfile.python2 .
docker tag xvtsolutions/python2-aws-ansible:$ANSIBLE_VERSION xvtsolutions/python2-aws-ansible:latest
docker push xvtsolutions/python2-aws-ansible:$ANSIBLE_VERSION
docker push xvtsolutions/python2-aws-ansible:latest
}

#### Execution
echo "Build ubuntu image? y/n "
read ans
[ "$ans" == "y" ] && build_ubuntu && ans='n'

echo "Build ubuntu python2 image? y/n "
read ans
[ "$ans" == "y" ] && build_ubuntu_python2 && ans='n'

echo "Build alpine image? y/n "
read ans
[ "$ans" == "y" ] && build_alpine && ans='n'

echo "Build alpine python2 image? y/n "
read ans
[ "$ans" == "y" ] && build_alpine_python2 && ans='n'

echo "Build clearlinux python3 image? y/n "
read ans
[ "$ans" == "y" ] && build_clearlinux && ans='n'
