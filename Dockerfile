# escape=`
FROM lacledeslan/steamcmd:linux as warsow-builder

ARG contentServer=content.lacledeslan.net

# Get base game content
RUN curl -sSL "http://${contentServer}/fastDownloads/_installers/warsow-2.1.2.tar.gz" -o /tmp/warsow-2.1.2.tar.gz &&`
    echo "40e3277a3f8f7f70b6f887a8a7b286d48641241d /tmp/warsow-2.1.2.tar.gz" | sha1sum -c - &&`
    tar -zxvf /tmp/warsow-2.1.2.tar.gz --directory /output --strip-components=1

RUN echo "Downloading LL custom content from content server" &&`
    wget -rkpN -nH -q --cut-dirs=2 -e robots=off --no-parent --reject "index.html*" -P /output "http://"$contentServer"/fastDownloads/warsow/";

#=======================================================================
FROM debian:stable-slim

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

LABEL maintainer="Laclede's LAN <contact @lacledeslan.com>" `
      com.lacledeslan.build-node=$BUILDNODE `
      org.label-schema.schema-version="1.0" `
      org.label-schema.url="https://github.com/LacledesLAN/README.1ST" `
      org.label-schema.vcs-ref=$SOURCE_COMMIT `
      org.label-schema.vendor="Laclede's LAN" `
      org.label-schema.description="Warsow Dedicated Server in Docker" `
      org.label-schema.vcs-url="https://github.com/LacledesLAN/gamesvr-warsow"

COPY --chown=Warsow:root --from=warsow-builder /output /app

COPY --chown=Warsow:root /dist /app

COPY --chown=Warsow:root ./ll-tests /app/ll-tests

RUN chmod +x /app/ll-tests/*.sh;

USER Warsow

WORKDIR /app

CMD ["/bin/bash"]

ONBUILD USER root
