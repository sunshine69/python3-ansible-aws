FROM ubuntu:latest

RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get install -y python3 python3-pip git rsync p7zip zip vim \
    && ln -sf /usr/bin/pip3 /usr/bin/pip \
    && ln -sf /usr/bin/python3 /usr/bin/python

RUN pip3 install --upgrade pip \
    && pip install botocore boto3 boto awscli \
    && pip install ansible=${ANSIBLE_VERSION:2.6.3} \
    && rm -rf ~/.cache

#ENTRYPOINT ["python3"]
