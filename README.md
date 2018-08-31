# Description

docker image for running ansible playbook to deploy on aws.

It has git, python3, boto, boto3, ansible, awscli and populate archiving tool such as rsync, zip, 7zip and xz.

There are three base image option, ubuntu18, alpine and clearlinux. 

Clearlinux is the largest but *supposedly* the fastest while alpine version has smallest image size but might be a bit slow to run. So if you run cpu intensive python data miner for example, better use clearlinux based image.
