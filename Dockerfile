
# Dockerized Cloud-Client 4.4 + Useful Import/Export Scripts

# Author adess@vmware.com
# Source taken from: https://code.vmware.com/web/dp/tool/cloudclient/4.4.0

FROM ubuntu:latest

# Removed odefault-jre

RUN apt-get update && apt-get install -y \
    default-jre-headless \
    vim


# Create working directory and hidden config directory
RUN mkdir /cloudclient
RUN mkdir /cloudclient/scripts
RUN mkdir /root/.cloudclient

# Add the CloudClient folder to the image:
ADD CloudClient/ /cloudclient
ADD scripts/ /cloudclient/scripts
# Config file is located when installing: /root/.cloudclient/cloudclient.config. Only to acceppt the EULA
ADD cloudclient.config /root/.cloudclient

WORKDIR /cloudclient/scripts

# Start the client:
ENTRYPOINT /bin/bash

#Uncomment to shart the Cloudclient when the container starts:
#WORKDIR /cloudclient/bin
#CMD ["sh","cloudclient.sh"]
