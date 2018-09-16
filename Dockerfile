# AS IT STANDS NOW ITS INCOMPLETE. CANNOT LL BASE CONFIG COPIED IN


FROM debian:stable-slim

ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified
ARG contentServer=content.lacledeslan.net
RUN mkdir /app;
#RUN useradd --home /app --gid root --system WARSOW &&` mkdir -p /app/ll-tests &&`chown WARSOW:root -R /app

# Install dependencies
RUN dpkg --add-architecture i386
RUN apt-get update; apt-get install -y bzip2 curl git lib32gcc1 tar unzip wget; apt-get autoremove; apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#Getting base game

RUN cd /app; wget -nv http://sebastian.network/warsow/warsow-2.1.2.tar.gz; tar -zxvf warsow-2.1.2.tar.gz


# Downloading LL custom content from content server

RUN cd /app/warsow-2.1.2/; wget -rkpN -nH -q --cut-dirs=2 -e robots=off --no-parent --reject "index.html*" http://content.lacledeslan.net/fastDownloads/warsow/; 



# Add in tests
# COPY /ll-tests /app/ll-tests

# Getting LL config

COPY /dist /app/warsow-2.1.2/

WORKDIR /app
CMD ["/bin/bash"]
ONBUILD USER root
