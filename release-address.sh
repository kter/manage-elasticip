#!/bin/bash
INSTANCE=i-8c3cc57e

# Get AllocationId
AllocationId=`aws --profile aws ec2 describe-addresses --filters Name=instance-id,Values=$INSTANCE |  jq -r '.Addresses[].AllocationId'`

# release ElasticIp by using AllocationId
aws --profile aws ec2 release-address --allocation-id $AllocationId
