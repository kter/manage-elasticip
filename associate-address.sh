#!/bin/bash
INSTANCE=i-8c3cc57e
TMPLPATH=`dirname $0`
ZONEID=Z17RJXG9LMA7ED

AllocationId=`aws --profile aws ec2 allocate-address --domain vpc | jq -r '.AllocationId'`

result=`aws --profile aws ec2 associate-address --instance-id $INSTANCE --allocation-id $AllocationId`

IP=`aws --profile aws ec2 describe-addresses --filters Name=instance-id,Values=$INSTANCE | jq -r '.Addresses[].PublicIp'`

sed -e "s/{%IP%}/${IP}/g" $TMPLPATH/dyndns.tmpl > /tmp/r53.json

result=`aws --profile aws route53 change-resource-record-sets --hosted-zone-id ${ZONEID} --change-batch file:///tmp/r53.json`
