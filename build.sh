#!/bin/bash

for base_image in ubuntu:latest alpine:latest amd64/clearlinux:latest; do
    echo docker pull $base_image
done

ANSIBLE_VERSION=2.7.0

docker build -t xvtsolutions/clearlinux-python3-aws-ansible:${ANSIBLE_VERSION} -f Dockerfile.clearlinux .
docker tag xvtsolutions/clearlinux-python3-aws-ansible:${ANSIBLE_VERSION} xvtsolutions/clearlinux-python3-aws-ansible:latest
docker push xvtsolutions/clearlinux-python3-aws-ansible:${ANSIBLE_VERSION}
docker push xvtsolutions/clearlinux-python3-aws-ansible:latest

docker build -t xvtsolutions/alpine-python3-aws-ansible:${ANSIBLE_VERSION} -f Dockerfile.alpine .
docker tag xvtsolutions/alpine-python3-aws-ansible:${ANSIBLE_VERSION} xvtsolutions/alpine-python3-aws-ansible:latest
docker push xvtsolutions/alpine-python3-aws-ansible:${ANSIBLE_VERSION}
docker push xvtsolutions/alpine-python3-aws-ansible:latest

docker build -t xvtsolutions/clearlinux-python2-aws-ansible:${ANSIBLE_VERSION} -f Dockerfile-python2.clearlinux .
docker tag xvtsolutions/clearlinux-python2-aws-ansible:${ANSIBLE_VERSION} xvtsolutions/clearlinux-python2-aws-ansible:latest
docker push xvtsolutions/clearlinux-python2-aws-ansible:${ANSIBLE_VERSION}
docker push xvtsolutions/clearlinux-python2-aws-ansible:latest

docker build -t xvtsolutions/alpine-python2-aws-ansible:${ANSIBLE_VERSION} -f Dockerfile-python2.alpine .
docker tag xvtsolutions/alpine-python2-aws-ansible:${ANSIBLE_VERSION} xvtsolutions/alpine-python2-aws-ansible:latest
docker push xvtsolutions/alpine-python2-aws-ansible:${ANSIBLE_VERSION}
docker push xvtsolutions/alpine-python2-aws-ansible:latest

docker build -t xvtsolutions/python3-aws-ansible:${ANSIBLE_VERSION} -f Dockerfile .
docker tag xvtsolutions/python3-aws-ansible:${ANSIBLE_VERSION} xvtsolutions/python3-aws-ansible:latest
docker push xvtsolutions/python3-aws-ansible:${ANSIBLE_VERSION}
docker push xvtsolutions/python3-aws-ansible:latest


