# ip-project

Figure 1 - Deployment

CloudFormation - The CloudFormation template will
deploy AWS resources across the following services:

API Gateway - Acts as the frontend REST API that
services the Post requests containing the IP address
in question. the /ip endpoint invokes an AWS Lambda
function.

AWS Lambda - Python3 Lambda. Parses the request
for the IP address, instantiates MySQL client,
performs SQL queries to find blocklists containing the
IP address sent. Returns JSON response containing
an array of all blocklists the IP address is present in...
or an empty array if not in any lists.

Amazon RDS - MySQL database configured in MultiAZ for HA.

![CloudFormation Deployment](/images/1.jpg)

Figure 2 - IP and Network Data processing

Container's primary job is to get data into RDS.

![TypeScript Node Docker Container](/images/2.jpg)

Figure 3 - Traffic Flow

Client sends HTTP POST Request
```
curl -H "Content-Type: application/json" \
 -d '{"ip": "8.8.8.8"}' \
 -X POST \
 https://id.execute-api.us-west-2.amazonaws.com/ip
```

Sample Response:
```
{
 "ip_lists":[
 "coinbl_hosts.ipset",
 "hphosts_ats.ipset",
 "hphosts_emd.ipset",
 "hphosts_fsa.ipset",
 "hphosts_psh.ipset",
 "packetmail_emerging_ips.ipset"
 ]
}
```

![API Traffic Flow](/images/3.jpg)
