# Container image that runs your code
FROM ubuntu:18.04

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

RUN apt-get update && apt-get install -y \
    zip \
    sshpass

# Code file to execute when the docker container starts up (`entrypoint.sh`)
RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]
