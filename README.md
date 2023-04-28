# route53-misconfiguration-scanner
This script scans for all the Hosted Zones in your AWS account to find if any of your DNS Name(.AliasTarget.DNSName) has value "s3-website.&lt;your-aws-region>.amazonaws.com" and the DNS Record Name does not exists.
