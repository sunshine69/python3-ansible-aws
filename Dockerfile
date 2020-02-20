FROM ubuntu:19.04

ARG ANSIBLE_VERSION=${ANSIBLE_VERSION:-2.7.9}

RUN apt-get -y update && apt-get -y upgrade 
RUN apt-get install -y python3 python3-pip git rsync p7zip zip vim curl iproute2 \
    python3-dev default-libmysqlclient-dev libpq-dev libssl-dev \
    && ln -sf /usr/bin/pip3 /usr/bin/pip \
    && ln -sf /usr/bin/python3 /usr/bin/python

RUN pip3 install --upgrade pip \
    && pip install pyasn1 cryptography --upgrade --force-reinstall \
    && pip install botocore boto3 boto awscli pywinrm[credssp] requests-credssp pyyaml \
    pyotp qrcode[pil] requests pymssql==2.1.4 beautifulsoup4 psycopg2 \
    netaddr pexpect pycrypto cryptography pytz mysqlclient \
    && pip install ansible==$ANSIBLE_VERSION

RUN apt-get clean && rm -rf ~/.cache

COPY assumerole.py /
ADD https://xvt-public-repo.s3-ap-southeast-2.amazonaws.com/pub/devops/nsre-ubuntu-1804-amd64 /usr/bin/nsre

ENTRYPOINT ["tail", "-f", "/dev/null"]
