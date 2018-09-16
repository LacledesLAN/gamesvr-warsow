# AS IT STANDS NOW ITS INCOMPLETE. CANNOT GET CUSTOM CONTENT AND LL BASE CONFIG COPIED IN


FROM debian:stable-slim

ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified
ARG contentServer=content.lacledeslan.net


# Install dependencies
RUN apt-get update; apt-get install -y bzip2 curl git lib32gcc1 tar unzip wget; apt-get autoremove; apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#Getting base game

RUN mkdir /app; cd /app; wget -nv http://sebastian.network/warsow/warsow-2.1.2.tar.gz; tar -zxvf warsow-2.1.2.tar.gz

RUN cd /app/warsow-2.1.2/ 

# Downloading LL custom content from content server
RUN wget -rkpN -nH -q --cut-dirs=2 -e robots=off --no-parent --reject "index.html*" http://content.lacledeslan.net/fastDownloads/warsow/  

RUN cd /app


# Add in tests
# COPY /ll-tests /app/ll-tests

# Getting LL config
RUN cd /app
RUN git clone https://github.com/LacledesLAN/gamesvr-warsow/
RUN cp -f /app/gamesvr-warsow/basewsw/*  /app/warsow-2.1.2/basewsw  


WORKDIR /app

ONBUILD USER root
