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

ADD https://xvt-public-repo.s3-ap-southeast-2.amazonaws.com/pub/devops/nsre-linux-amd64-static /usr/bin/nsre

RUN chmod +x /usr/bin/nsre ; apt-get clean && rm -rf ~/.cache

COPY assumerole.py /
# Ugly patch until anisbel pr is merged
COPY elbv2.py /usr/local/lib/python3.7/dist-packages/ansible/module_utils/aws/elbv2.py


ENTRYPOINT ["tail", "-f", "/dev/null"]
