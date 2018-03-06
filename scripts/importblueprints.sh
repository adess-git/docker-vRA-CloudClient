
#!/bin/sh

# Setup env for the auto-logon
. ./import-env.sh

# Loop through to export each blueprint
for i in `cat /tmp/blueprintIds.txt`; do
    $cloudclient_home/bin/cloudclient.sh vra content import --path /tmp/$i.zip --resolution OVERWRITE --precheck WARN
done

# Close Session
$cloudclient_home/bin/cloudclient.sh vra logout
