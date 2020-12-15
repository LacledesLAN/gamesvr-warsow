# escape=`
ARG CONTAINER_REGISTRY="docker.io"

FROM $CONTAINER_REGISTRY/lacledeslan/steamcmd as warsow-builder

ARG CONTENT_SERVER="http://content.lacledeslan.net"

# Get base game content
RUN echo "Downloading Warsow dedicated server from install from content server" &&`
        mkdir --parents /downloads &&`
        curl -sSL "${CONTENT_SERVER}/fastDownloads/_installers/warsow-2.1.2.tar.gz" -o /downloads/warsow-installer.tar.gz &&`
    echo "Validating download against last known hash" &&`
        echo "40e3277a3f8f7f70b6f887a8a7b286d48641241d /downloads/warsow-installer.tar.gz" | sha1sum -c - &&`
    echo "Extracting dedicated server files" &&`
        tar -zxvf /downloads/warsow-installer.tar.gz --directory /output --strip-components=1 &&`
    echo "Downloading custom content from content server" &&`
        wget -rkpN -nH -q --cut-dirs=2 -e robots=off --no-parent --reject "index.html*" -P /output $CONTENT_SERVER"/fastDownloads/warsow/";

#=======================================================================
FROM $CONTAINER_REGISTRY/debian:stable-slim

ARG BUILDNODE="unspecified"
ARG SOURCE_COMMIT

HEALTHCHECK NONE

RUN dpkg --add-architecture i386 &&`
    apt-get update && apt-get install -y `
        ca-certificates lib32gcc1 locales locales-all tmux &&`
        apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* &&`
    echo "LC_ALL=en_US.UTF-8" >> /etc/environment &&`
    useradd --home /app --gid root --system Warsow

ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

LABEL com.lacledeslan.build-node $BUILDNODE `
        org.opencontainers.image.source https://github.com/LacledesLAN/gamesvr-warsow `
        org.opencontainers.image.title "Laclede's LAN Warsow Dedicated Server" `
        org.opencontainers.image.url https://github.com/LacledesLAN/README.1ST `
        org.opencontainers.image.vendor "Laclede's LAN <contact @lacledeslan.com>" `
        org.opencontainers.image.version $SOURCE_COMMIT

COPY --chown=Warsow:root --from=warsow-builder /output /app

# `RUN true` lines are work around for https://github.com/moby/moby/issues/36573
RUN true

COPY --chown=Warsow:root ./dist-linux/ll-tests /app/ll-tests

RUN chmod +x /app/ll-tests/*.sh;

COPY --chown=Warsow:root /dist /app

USER Warsow

WORKDIR /app

CMD ["/bin/bash"]

ONBUILD USER root
