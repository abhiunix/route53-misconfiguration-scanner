# route53-misconfiguration-scanner


This script scans for all the Hosted Zones in your AWS account to find if any of your DNS Name is misconfigured and is pointing to non-existing s3 bucket.



### Pre-requisites:
> You need to run this script with access to route53 from your aws console, so it can fetch all hosted zone ids and perform further checks.

## Usage:

```
route53_scanner.sh <your-aws-region>
```

## Example:

if you are in India and using Asia Pacific (Mumbai)region then use ap-south-1.
```
route53_scanner.sh ap-south-1
```

## Results:
```
cat buckets_to_check.txt
```
buckets_to_check.txt file will contain those buckets which does not exists. An attacker can claim those buckets and use the website for phishing or spread malware.

List of Regions can be found here: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html
