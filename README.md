# Docker vRA CloudClient + Scripts

## Introduction

> vRealize CloudClient is a simple and useful application for exporting and importing content from vRA. Sometimes I face the issue that i cannot simply install the necessary dependencies or pull my scripts. In addition to this it´s a very manual task to work with the cloud-client since you need to export and import EACH single blueprint manually. This image has CloudClient 4.4 preinstalled and puts you to a script folder with some useful import/export scripts. You can use the scripts or just leverage the CloudClient like you are used to.

## Code Samples

Export the Blueprints:

>#Execute CloudClient:
> >$cloudclient_home/bin/cloudclient.sh vra content list --format CSV --export /tmp/list-blueprints.txt

> #Remove all but blueprints + remove all except the id:

>>grep composite /tmp/list-blueprints.txt | awk -F , {'print $2'} | sed '2d' > /tmp/blueprintIds.txt

>#Loop to export all blueprints to tmp
>>for i in `cat /tmp/blueprintIds.txt`; do
    $cloudclient_home/bin/cloudclient.sh vra content export --path /tmp/$i --type composite-blueprint --content-id $i
done

Import of Blueprints is basically one loop:
> for i in `cat /tmp/blueprintIds.txt`; do
    $cloudclient_home/bin/cloudclient.sh vra content import --path /tmp/$i.zip --resolution OVERWRITE --precheck WARN
done

## Installation

> Run the image interactive eg. docker run -it adess/cloudclient-scripts. This will put you to a shell and the scripts directory. All you need to do is to edit the two files called "export-env.sh" with the values of your environment where you want to export the blueprints and the file "import-env.sh" with the values of the environment where you want to import the blueprints.

>After this just run ./exportblueprints.sh to export the Blueprints. You can review them in /tmp once finished and remove unneccessary stuff. To import just run ./importblueprints.sh. If yo want to run cloudclient the normal way just run ./cloudclient-interactive.sh.

> Cloud-Client used: https://code.vmware.com/web/dp/tool/cloudclient/4.4.0

# Warning: All existing Blueprints in the "import-env.sh" will be overwritten
