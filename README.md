# Description

docker image for running ansible playbook to deploy on cloud. Currently it has aws azure

It has git, python3, boto, boto3, ansible, awscli and populate archiving tool such as rsync, zip, 7zip and xz.

There are three base image option, ubuntu18, alpine and clearlinux. 

Clearlinux is the largest but *supposedly* the fastest while alpine version has smallest image size but might be a bit slow to run. So if you run cpu intensive python data miner for example, better use clearlinux based image.

The purpose is to build a tested environment to run ansible and cloud tools such as awscli, aws ansible module and azure cli, ansible azure module. As you can see ansible ans azure development moves so fast and sometimes bug fix is so slow, incompatibility arrises frequently. Using this image will address that issues.

Currently azure-cli and ansible[azure] not playwell with each other, the outcome is that azure-cli must live within virtual env for now.

The latest images I build is `stevekieu/python3-cloud-ansible:2.9.9` and it is built off the file `Dockerfile.ubuntu18-aws-azure`. Others are not mainatained but you can build your own.
