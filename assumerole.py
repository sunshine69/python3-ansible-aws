#!/usr/bin/python3
#
# Usage: assumerole.py arn sessionname
#
# read AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN < <(python assumerole.py arn:aws:iam::988497896458:role/AMIBuilder hello)
# export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
# aws ec2 describe-instances

import boto3
import botocore
import sys

try:
    sts = boto3.session.Session().client('sts')
    credentials = sts.assume_role(RoleArn=sys.argv[1], RoleSessionName=sys.argv[2])['Credentials']
except botocore.exceptions.ClientError as e:
    raise SystemExit(e.response)

print(credentials['AccessKeyId'], credentials['SecretAccessKey'], credentials['SessionToken'])
