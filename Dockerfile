FROM ubuntu:latest

ARG ANSIBLE_VERSION=${ANSIBLE_VERSION:-2.6.4}

RUN apt-get -y update && apt-get -y upgrade 
RUN apt-get install -y python3 python3-pip git rsync p7zip zip vim \
    python3-dev default-libmysqlclient-dev \
    && ln -sf /usr/bin/pip3 /usr/bin/pip \
    && ln -sf /usr/bin/python3 /usr/bin/python

RUN pip3 install --upgrade pip \
    && pip install botocore boto3 boto awscli \
    pyotp qrcode[pil] requests pymssql beautifulsoup4 psycopg2 \
    netaddr pexpect pycrypto cryptography pytz mysqlclient \
    && pip install ansible==$ANSIBLE_VERSION

RUN apt-get clean && rm -rf ~/.cache

COPY assumerole.py /

ENTRYPOINT ["tail", "-f", "/dev/null"]
