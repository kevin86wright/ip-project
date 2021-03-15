git clone https://github.com/firehol/blocklist-ipsets.git
mysql -u username -ppassword -h aws-ip-database-1.cmpzqcspudxe.us-west-2.rds.amazonaws.com < rds.sql
ts-node process.ts
mysql -u username -ppassword -h aws-ip-database-1.cmpzqcspudxe.us-west-2.rds.amazonaws.com -D ip_project < table_migrate.sql
