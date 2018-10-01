# Warsow Dedicated Server in Docker

Since 2005, Warsow is considered as one of the most skill-demanding games in the fast-paced arena shooter scene. Warsow's goal is to offer a fast and fun competitive first-person shooter without hard graphical violence - Warsow has no blood or guts flying around. Red circles instead of blood indicate hits and colored triangles replace guts as gib effects. Warsow's emphasis  is on extreme customazibility  and e-sports features.

![Warsow Logo](https://raw.githubusercontent.com/LacledesLAN/gamesvr-warsow/master/.misc/warsow-logo.jpg "Warsow Logo")

This repository is maintained by [Laclede's LAN](https://lacledeslan.com). Its contents are intended to be bare-bones and used as a stock server. For examples of building a customized server from this Docker image browse its related child-project [gamesvr-warsow-freeplay](https://github.com/LacledesLAN/gamesvr-warsow-freeplay). If any documentation is unclear or it has any issues please see [CONTRIBUTING.md](./CONTRIBUTING.md).

## Linux

### Download

```shell
docker pull lacledeslan/gamesvr-warsow;
```

### Run Self Tests

The image includes a test script that can be used to verify its contents. No changes or pull-requests will be accepted to this repository if any tests fail.

```shell
docker run -it --rm lacledeslan/gamesvr-warsow ./ll-tests/gamesvr-warsow.sh;
```

### Run Interactive Server

```shell
docker run -it --rm lacledeslan/gamesvr-warsow ./wsw_server +exec server.cfg +set dedicated 2 +sv_lan 1
```

## Getting Started with Game Servers in Docker

[Docker](https://docs.docker.com/) is an open-source project that bundles applications into lightweight, portable, self-sufficient containers. For a crash course on running Dockerized game servers check out [Using Docker for Game Servers](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/DockerAndGameServers.md). For tips, tricks, and recommended tools for working with Laclede's LAN Dockerized game server repos see the guide for [Working with our Game Server Repos](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/WorkingWithOurRepos.md). You can also browse all of our other Dockerized game servers: [Laclede's LAN Game Servers Directory](https://github.com/LacledesLAN/README.1ST/tree/master/GameServers).

