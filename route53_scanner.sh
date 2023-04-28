#!/bin/bash
#Author: @abhiunix

AWS_REGION=$1

echo "" | cat > buckets_to_check.txt

hosted_zones=$(aws route53 list-hosted-zones --query "HostedZones[*].Id" --output text)

for zone_id in $hosted_zones; do
    dns_names=$(aws route53 list-resource-record-sets --hosted-zone-id $zone_id --query "ResourceRecordSets[?AliasTarget.DNSName=='s3-website.$AWS_REGION.amazonaws.com.'].Name" --output text)
    if [ ! -z "$dns_names" ]; then
        echo "DNS names for hosted zone $zone_id having record value s3-website.$AWS_REGION.amazonaws.com."
        echo "$dns_names" | sed 's/\t/\n/g'
        echo $(echo "$dns_names" | sed 's/\t/\n/g' | awk '{print substr($0, 1, length($0)-1)}') >> temp1.txt
        sed 's/ /\n/g' temp1.txt > temp2.txt 
    fi
done

mv temp2.txt buckets_to_check.txt


while read bucket_name; do
    if aws s3 ls "s3://$bucket_name" 2>&1 | grep -q 'NoSuchBucket'; then
        echo "Bucket $bucket_name does not exist. This bucket is vulnerable to subdomain takeover."
        echo "$bucket_name" > bucket_names_to_takeover.txt
    else
        echo "Bucket $bucket_name exists"
    fi
done < buckets_to_check.txt

