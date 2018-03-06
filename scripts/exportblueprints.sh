# VRA Content export Script will only export composite blueprints

#!/bin/sh

#
# Setup env for the auto-logon
. ./export-env.sh

# Execute CloudClient
$cloudclient_home/bin/cloudclient.sh vra content list --format CSV --export /tmp/list-blueprints.txt

# Remove all but blueprints + remove all except the id
grep composite /tmp/list-blueprints.txt | awk -F , {'print $2'} | sed '2d' > /tmp/blueprintIds.txt

# Loop to export all blueprints to tmp
for i in `cat /tmp/blueprintIds.txt`; do
    $cloudclient_home/bin/cloudclient.sh vra content export --path /tmp/$i --type composite-blueprint --content-id $i
done

# Close the session
$cloudclient_home/bin/cloudclient.sh vra logout
