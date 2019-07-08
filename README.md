[ ![Codeship Status for novacoast/opensuse-apache-docker](https://codeship.com/projects/b0bd21b0-5274-0132-69f7-72279d09a1d7/status)](https://codeship.com/projects/48655) [![Code Climate](https://codeclimate.com/github/novacoast/opensuse-apache-docker/badges/gpa.svg)](https://codeclimate.com/github/novacoast/opensuse-apache-docker)


# Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Quick Start](#quick-start)
- [Installation](#installation)
- [Upgrading](#upgrading)
- [Docker Compose](#docker-compose)
- [Contributing](#contributing)
- [need_to_install](#need_to_install)
- [start_service](#start_service)




# need_to_install:
```bash
zypper -n in docker
zypper -n in git
```
# start_service:
```bash
rcdocker start
```

# Introduction

Dockerfile to build an OpenSUSE 42.3 container image with apache2 and php7.

## Features:
- Apache2
- php7 & common modules
- php.ini configured to utilize `getenv()`

# Quick Start

- Pull image from docker
```bash
docker pull nu11secur1ty/suse-apache-docker-php7
```
- Run the opensuse-apache-docker image

```bash
docker run -d -p 8080:80 nu11secur1ty/suse-apache-docker-php7
```
- Output
```bash 
http://localhost:8080/
```
![]()

# Check for docker running containers:
```bash
docker container ls
docker ps -a
```
# Check for docker images:
```bash
docker images
```

# Installation

Pull the latest version of the image from the docker index. These builds are performed by the **Docker Trusted Build** service.

https://hub.docker.com/r/nu11secur1ty/suse-apache-docker-php7

```bash
docker pull nu11secur1ty/opensuse-apache-docker-php7:latest
```

Alternately you can build the image yourself.

```bash
git clone https://github.com/nu11secur1ty/suse-apache-docker-php7.git
cd suse-apache-docker-php7
docker build -t="$USER/suse-apache-docker-php7" .
```

# Upgrading

To upgrade to newer releases, simply follow this 3 step upgrade procedure.

- **Step 1**: Stop the currently running image

```bash
docker stop suse-apache-docker-php7
```

- **Step 2**: Update the docker image.

```bash
docker pull nu11secur1ty/suse-apache-docker-php7:latest
```

- **Step 3**: Start the image

```bash
docker run --name='suse-apache' -d -p 8080:80 nu11secur1ty/suse-apache-docker-php7
echo "or"
docker run --name='suse-apache' -d -p 80:80 nu11secur1ty/suse-apache-docker-php7
```

# Docker-Compose

Build and run using [docker-compose](https://github.com/docker/compose)

```bash
git clone https://github.com/nu11secur1ty/suse-apache-docker-php7.git
cd suse-apache-docker-php7
docker-compose build
docker-compose up
```

The [webapp](webapp) folder on the host will be mounted into the container's apache root

# Contributing

+ Report Issues
+ Open a Pull Request


------------------------------------------------------------------------------------------------------


# Docker provides a single command that will clean up any resources — images, containers, volumes, and networks — that are dangling (not associated with a container):

```bash
docker system prune
```


# To additionally remove any stopped containers and all unused images (not just dangling images), add the -a flag to the command:

```bash 
docker system prune -a
```

# Remove one or more specific images

Use the docker images command with the -a flag to locate the ID of the images you want to remove. This will show you every image, including intermediate image layers. When you've located the images you want to delete, you can pass their ID or tag to docker rmi:

- **List:**
```bash
docker images -a
```
- **Remove:**
```bash 
docker rmi Image Image
```
# Remove dangling images

Docker images consist of multiple layers. Dangling images are layers that have no relationship to any tagged images. They no longer serve a purpose and consume disk space. They can be located by adding the filter flag, -f with a value of dangling=true to the docker images command. When you're sure you want to delete them, you can use the docker images purge command:

**NOTE**
```txt
If you build an image without tagging it, the image will appear on the list of dangling images because it has no association with a tagged image. You can avoid this situation by providing a tag when you build, and you can retroactively tag an images with the docker tag command.
```
- **List:**
```bash
docker images -f dangling=true
```
- **Remove:**
```
docker images purge
```
# Removing images according to a pattern

You can find all the images that match a pattern using a combination of docker images and grep. Once you're satisfied, you can delete them by using awk to pass the IDs to docker rmi. Note that these utilities are not supplied by Docker and are not necessarily available on all systems:

- **List:**
```bash
docker images -a |  grep "pattern"
```

- **Remove:**
```bash
docker images -a | grep "pattern" | awk '{print $3}' | xargs docker rmi
```
# Remove all images

All the Docker images on a system can be listed by adding -a to the docker images command. Once you're sure you want to delete them all, you can add the -q flag to pass the Image ID to docker rmi:

- **List:**
```bash
docker images -a
```
- **Remove:**
```bash
docker rmi $(docker images -a -q)
```
# Remove a container upon exit

If you know when you’re creating a container that you won’t want to keep it around once you’re done, you can run docker run --rm to automatically delete it when it exits.

- **Run and Remove:**
```bash
 docker run --rm image_name
```
# Remove all exited containers

You can locate containers using docker ps -a and filter them by their status: created, restarting, running, paused, or exited. To review the list of exited containers, use the -f flag to filter based on status. When you've verified you want to remove those containers, using -q to pass the IDs to the docker rm command.

- **List:**
```bash
docker ps -a -f status=exited
```
- **Remove:**
```bash
docker rm $(docker ps -a -f status=exited -q)
```
# Remove containers using more than one filter

Docker filters can be combined by repeating the filter flag with an additional value. This results in a list of containers that meet either condition. For example, if you want to delete all containers marked as either Created (a state which can result when you run a container with an invalid command) or Exited, you can use two filters:

- **List:**
```bash
docker ps -a -f status=exited -f status=created
```
- **Remove:**
```bash
docker rm $(docker ps -a -f status=exited -f status=created -q)
```
# Remove containers according to a pattern

You can find all the containers that match a pattern using a combination of docker ps and grep. When you're satisfied that you have the list you want to delete, you can use awk and xargs to supply the ID to docker rmi. Note that these utilities are not supplied by Docker and not necessarily available on all systems:

- **List:**
```bash
docker ps -a |  grep "pattern”
```
- **Remove:**
```bash
docker ps -a | grep "pattern" | awk '{print $3}' | xargs docker rmi
```
# Stop and remove all containers

You can review the containers on your system with docker ps. Adding the -a flag will show all containers. When you're sure you want to delete them, you can add the -q flag to supply the IDs to the docker stop and docker rm commands:

- **List:**
```bash
docker ps -a
```
- **Remove:**
```bash
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
```
# Removing Volumes
Remove one or more specific volumes - Docker 1.9 and later

Use the docker volume ls command to locate the volume name or names you wish to delete. Then you can remove one or more volumes with the docker volume rm command:

- **List:**
```bash
docker volume ls
```
- **Remove:**
```bash
docker volume rm volume_name volume_name
```
# Remove dangling volumes - Docker 1.9 and later

Since the point of volumes is to exist independent from containers, when a container is removed, a volume is not automatically removed at the same time. When a volume exists and is no longer connected to any containers, it's called a dangling volume. To locate them to confirm you want to remove them, you can use the docker volume ls command with a filter to limit the results to dangling volumes. When you're satisfied with the list, you can remove them all with docker volume prune:

- **List:**
```bash
docker volume ls -f dangling=true
```
- **Remove:**
```
docker volume prune
```
# Remove a container and its volume

If you created an unnamed volume, it can be deleted at the same time as the container with the -v flag. Note that this only works with unnamed volumes. When the container is successfully removed, its ID is displayed. Note that no reference is made to the removal of the volume. If it is unnamed, it is silently removed from the system. If it is named, it silently stays present.

- **Remove:**
```bash
docker rm -v container_name
```
# Conclusion

This guide covers some of the common commands used to remove images, containers, and volumes with Docker. There are many other combinations and flags that can be used with each. For a comprehensive guide to what's available, see the Docker documentation for docker system prune, docker rmi, docker rm and docker volume rm. If there are common cleanup tasks you'd like to see in the guide, please ask or make suggestions in the comments.

------------------------------------------------------------------------------------------------------------------------

# Vulnerabilities

![](https://github.com/nu11secur1ty/opensuse-apache-docker/blob/master/Screenshot%20from%202018-05-12%2020-31-11.png)

# Packages providing

![](https://github.com/nu11secur1ty/opensuse-apache-docker/blob/master/Screenshot%20from%202018-05-12%2020-32-12.png)

# Build output
```bash
Building in Docker Cloud's infrastructure...
Cloning into '.'...
Warning: Permanently added the RSA host key for IP address '192.30.253.112' to the list of known hosts.
Reset branch 'master'
Your branch is up-to-date with 'origin/master'.
Pulling cache layers for index.docker.io/nu11secur1ty/suse-apache-docker-php7:latest...
Done!
KernelVersion: 4.4.0-1060-aws
Components: [{u'Version': u'18.03.1-ee-3', u'Name': u'Engine', u'Details': {u'KernelVersion': u'4.4.0-1060-aws', u'Os': u'linux', u'BuildTime': u'2018-08-30T18:42:30.000000000+00:00', u'ApiVersion': u'1.37', u'MinAPIVersion': u'1.12', u'GitCommit': u'b9a5c95', u'Arch': u'amd64', u'Experimental': u'false', u'GoVersion': u'go1.10.2'}}]
Arch: amd64
BuildTime: 2018-08-30T18:42:30.000000000+00:00
ApiVersion: 1.37
Platform: {u'Name': u''}
Version: 18.03.1-ee-3
MinAPIVersion: 1.12
GitCommit: b9a5c95
Os: linux
GoVersion: go1.10.2
Starting build of index.docker.io/nu11secur1ty/suse-apache-docker-php7:latest...
Step 1/8 : FROM opensuse/leap
---> 0182dffa8260
Step 2/8 : MAINTAINER "Ventsislav Varbanovski <venvaropt@gmail.com>"
---> Using cache
---> a1f9ce9c1d87
Step 3/8 : LABEL description="use this image to host your static web pages."
---> Running in 535abe998470
Removing intermediate container 535abe998470
---> 13d4c1ccabad
Step 4/8 : RUN zypper -n update && zypper -n install apache2
---> Running in 27ca7ab6aad0
Building repository 'Non-OSS Repository' cache [..
..done]
Building repository 'Main Repository' cache [..
..done]
Building repository 'Main Update Repository' cache [..
..done]
Building repository 'Update Repository (Non-Oss)' cache [..
..done]
Loading repository data...
Reading installed packages...
The following 5 packages are going to be upgraded:
libcom_err2 libdw1 libebl-plugins libelf1 liblzma5
5 packages to upgrade.
Overall download size: 437.1 KiB. Already cached: 0 B. No additional space will be used or freed after the operation.
Continue? [y/n/v/...? shows all options] (y): y
Retrieving package libcom_err2-1.43.8-lp151.5.3.1.x86_64 (1/5), 27.2 KiB ( 41.0 KiB unpacked)
Retrieving: libcom_err2-1.43.8-lp151.5.3.1.x86_64.rpm [
.
done]
Retrieving package liblzma5-5.2.3-lp151.4.3.1.x86_64 (2/5), 132.9 KiB (230.1 KiB unpacked)
Retrieving: liblzma5-5.2.3-lp151.4.3.1.x86_64.rpm [
done]
Retrieving package libdw1-0.168-lp151.4.3.1.x86_64 (3/5), 133.1 KiB (287.6 KiB unpacked)
Retrieving: libdw1-0.168-lp151.4.3.1.x86_64.rpm [
done]
Retrieving package libebl-plugins-0.168-lp151.4.3.1.x86_64 (4/5), 89.9 KiB (364.1 KiB unpacked)
Retrieving: libebl-plugins-0.168-lp151.4.3.1.x86_64.rpm [
.
done (7.8 KiB/s)]
Retrieving package libelf1-0.168-lp151.4.3.1.x86_64 (5/5), 54.0 KiB ( 94.6 KiB unpacked)
Retrieving: libelf1-0.168-lp151.4.3.1.x86_64.rpm [
done]
Checking for file conflicts: [....done]
(1/5) Installing: libcom_err2-1.43.8-lp151.5.3.1.x86_64 [.
....
.
........done]
(2/5) Installing: liblzma5-5.2.3-lp151.4.3.1.x86_64 [.
..
....
.
..
done]
(3/5) Installing: libdw1-0.168-lp151.4.3.1.x86_64 [.
..
.
....
.
..done]
(4/5) Installing: libebl-plugins-0.168-lp151.4.3.1.x86_64 [.
..
....
...
.......
done]
(5/5) Installing: libelf1-0.168-lp151.4.3.1.x86_64 [.
..
.
..
.
..done]
Loading repository data...
Reading installed packages...
Resolving package dependencies...
The following 34 NEW packages are going to be installed:
apache2 apache2-prefork apache2-utils blog dbus-1 kbd kbd-legacy kmod libapparmor1 libapr-util1 libapr1 libargon2-1 libbrotlicommon1 libbrotlienc1 libcryptsetup12 libdb-4_8 libdbus-1-3 libdevmapper1_03 libexpat1 libjson-c3 libkmod2 libqrencode4 libseccomp2 logrotate pam-config pkg-config system-user-wwwrun systemd systemd-presets-branding-openSUSE systemd-presets-common-SUSE sysvinit-tools udev which xz
The following 3 packages require a system reboot:
dbus-1 systemd udev
34 new packages to install.
Overall download size: 11.2 MiB. Already cached: 0 B. After the operation, additional 35.4 MiB will be used.
Note: System reboot required.
Continue? [y/n/v/...? shows all options] (y): y
Retrieving package blog-2.18-lp151.5.3.x86_64 (1/34), 53.6 KiB (129.0 KiB unpacked)
Retrieving: blog-2.18-lp151.5.3.x86_64.rpm [
done]
Retrieving package kbd-legacy-2.0.4-lp151.8.1.noarch (2/34), 502.8 KiB (517.0 KiB unpacked)
Retrieving: kbd-legacy-2.0.4-lp151.8.1.noarch.rpm [
.
done]
Retrieving package kmod-25-lp151.6.1.x86_64 (3/34), 142.7 KiB (289.6 KiB unpacked)
Retrieving: kmod-25-lp151.6.1.x86_64.rpm [
done]
Retrieving package libapparmor1-2.12.2-lp151.3.2.x86_64 (4/34), 34.1 KiB ( 67.5 KiB unpacked)
Retrieving: libapparmor1-2.12.2-lp151.3.2.x86_64.rpm [
done]
Retrieving package libapr1-1.6.3-lp151.2.2.x86_64 (5/34), 114.4 KiB (244.5 KiB unpacked)
Retrieving: libapr1-1.6.3-lp151.2.2.x86_64.rpm [
.
done (13.6 KiB/s)]
Retrieving package libargon2-1-0.0+git20171227.670229c-lp151.3.3.x86_64 (6/34), 19.9 KiB ( 30.2 KiB unpacked)
Retrieving: libargon2-1-0.0+git20171227.670229c-lp151.3.3.x86_64.rpm [
done]
Retrieving package libbrotlicommon1-1.0.2-lp151.2.3.x86_64 (7/34), 61.4 KiB (126.0 KiB unpacked)
Retrieving: libbrotlicommon1-1.0.2-lp151.2.3.x86_64.rpm [
done]
Retrieving package libdb-4_8-4.8.30-lp151.6.70.x86_64 (8/34), 694.1 KiB ( 3.1 MiB unpacked)
Retrieving: libdb-4_8-4.8.30-lp151.6.70.x86_64.rpm [
.
done]
Retrieving package libdbus-1-3-1.12.2-lp151.3.24.x86_64 (9/34), 149.7 KiB (325.9 KiB unpacked)
Retrieving: libdbus-1-3-1.12.2-lp151.3.24.x86_64.rpm [
done]
Retrieving package libdevmapper1_03-1.02.149-lp151.3.1.x86_64 (10/34), 180.0 KiB (345.8 KiB unpacked)
Retrieving: libdevmapper1_03-1.02.149-lp151.3.1.x86_64.rpm [
done]
Retrieving package libexpat1-2.2.5-lp151.2.4.x86_64 (11/34), 77.7 KiB (198.3 KiB unpacked)
Retrieving: libexpat1-2.2.5-lp151.2.4.x86_64.rpm [
done]
Retrieving package libjson-c3-0.13-lp151.2.3.x86_64 (12/34), 40.7 KiB ( 64.9 KiB unpacked)
Retrieving: libjson-c3-0.13-lp151.2.3.x86_64.rpm [
.
done (9.2 KiB/s)]
Retrieving package libkmod2-25-lp151.6.1.x86_64 (13/34), 99.1 KiB (212.5 KiB unpacked)
Retrieving: libkmod2-25-lp151.6.1.x86_64.rpm [
done]
Retrieving package libqrencode4-4.0.0-lp151.2.3.x86_64 (14/34), 28.8 KiB ( 50.0 KiB unpacked)
Retrieving: libqrencode4-4.0.0-lp151.2.3.x86_64.rpm [
done]
Retrieving package libseccomp2-2.3.2-lp151.2.3.x86_64 (15/34), 58.2 KiB (286.1 KiB unpacked)
Retrieving: libseccomp2-2.3.2-lp151.2.3.x86_64.rpm [
done]
Retrieving package pam-config-0.96-lp151.1.2.x86_64 (16/34), 129.0 KiB (626.8 KiB unpacked)
Retrieving: pam-config-0.96-lp151.1.2.x86_64.rpm [
.
done (15.6 KiB/s)]
Retrieving package pkg-config-0.29.2-lp151.2.70.x86_64 (17/34), 230.1 KiB (675.4 KiB unpacked)
Retrieving: pkg-config-0.29.2-lp151.2.70.x86_64.rpm [
done]
Retrieving package system-user-wwwrun-20170617-lp151.4.70.noarch (18/34), 10.3 KiB ( 96 B unpacked)
Retrieving: system-user-wwwrun-20170617-lp151.4.70.noarch.rpm [
done]
Retrieving package systemd-presets-common-SUSE-15-lp151.7.1.noarch (19/34), 19.9 KiB ( 4.0 KiB unpacked)
Retrieving: systemd-presets-common-SUSE-15-lp151.7.1.noarch.rpm [
done]
Retrieving package which-2.21-lp151.3.70.x86_64 (20/34), 38.8 KiB ( 75.1 KiB unpacked)
Retrieving: which-2.21-lp151.3.70.x86_64.rpm [
done]
Retrieving package sysvinit-tools-2.88+-lp151.2.3.x86_64 (21/34), 144.5 KiB (391.3 KiB unpacked)
Retrieving: sysvinit-tools-2.88+-lp151.2.3.x86_64.rpm [
.
done (12.1 KiB/s)]
Retrieving package kbd-2.0.4-lp151.8.1.x86_64 (22/34), 1.8 MiB ( 4.2 MiB unpacked)
Retrieving: kbd-2.0.4-lp151.8.1.x86_64.rpm [
done]
Retrieving package libbrotlienc1-1.0.2-lp151.2.3.x86_64 (23/34), 193.0 KiB (533.9 KiB unpacked)
Retrieving: libbrotlienc1-1.0.2-lp151.2.3.x86_64.rpm [
done]
Retrieving package libapr-util1-1.6.1-lp151.4.2.x86_64 (24/34), 101.3 KiB (240.5 KiB unpacked)
Retrieving: libapr-util1-1.6.1-lp151.4.2.x86_64.rpm [
.
done (15.6 KiB/s)]
Retrieving package dbus-1-1.12.2-lp151.3.24.x86_64 (25/34), 248.9 KiB (624.4 KiB unpacked)
Retrieving: dbus-1-1.12.2-lp151.3.24.x86_64.rpm [
done]
Retrieving package libcryptsetup12-2.0.5-lp151.1.17.x86_64 (26/34), 157.4 KiB (329.3 KiB unpacked)
Retrieving: libcryptsetup12-2.0.5-lp151.1.17.x86_64.rpm [
done]
Retrieving package systemd-presets-branding-openSUSE-12.2-lp151.13.2.noarch (27/34), 17.6 KiB ( 184 B unpacked)
Retrieving: systemd-presets-branding-openSUSE-12.2-lp151.13.2.noarch.rpm [
.
done (18.3 KiB/s)]
Retrieving package systemd-234-lp151.25.7.x86_64 (28/34), 2.7 MiB ( 9.2 MiB unpacked)
Retrieving: systemd-234-lp151.25.7.x86_64.rpm [
done]
Retrieving package udev-234-lp151.25.7.x86_64 (29/34), 1.4 MiB ( 7.4 MiB unpacked)
Retrieving: udev-234-lp151.25.7.x86_64.rpm [
done]
Retrieving package xz-5.2.3-lp151.4.3.1.x86_64 (30/34), 140.7 KiB (318.7 KiB unpacked)
Retrieving: xz-5.2.3-lp151.4.3.1.x86_64.rpm [
.
done]
Retrieving package apache2-utils-2.4.33-lp151.8.3.1.x86_64 (31/34), 123.0 KiB (198.2 KiB unpacked)
Retrieving: apache2-utils-2.4.33-lp151.8.3.1.x86_64.rpm [
done]
Retrieving package logrotate-3.13.0-lp151.4.2.x86_64 (32/34), 78.2 KiB (127.7 KiB unpacked)
Retrieving: logrotate-3.13.0-lp151.4.2.x86_64.rpm [
.
done (13.6 KiB/s)]
Retrieving package apache2-2.4.33-lp151.8.3.1.x86_64 (33/34), 1.2 MiB ( 4.1 MiB unpacked)
Retrieving: apache2-2.4.33-lp151.8.3.1.x86_64.rpm [
done]
Retrieving package apache2-prefork-2.4.33-lp151.8.3.1.x86_64 (34/34), 276.7 KiB (625.1 KiB unpacked)
Retrieving: apache2-prefork-2.4.33-lp151.8.3.1.x86_64.rpm [
.
done (1020 B/s)]
Checking for file conflicts: [...
.
....
.done]
( 1/34) Installing: blog-2.18-lp151.5.3.x86_64 [.
.
...
..
.
done]
( 2/34) Installing: kbd-legacy-2.0.4-lp151.8.1.noarch [.
.
.
.
.
.
.
.
.
.
.
.
done]
( 3/34) Installing: kmod-25-lp151.6.1.x86_64 [.
...........
done]
( 4/34) Installing: libapparmor1-2.12.2-lp151.3.2.x86_64 [.
....
done]
( 5/34) Installing: libapr1-1.6.3-lp151.2.2.x86_64 [.
.
..
......
done]
( 6/34) Installing: libargon2-1-0.0+git20171227.670229c-lp151.3.3.x86_64 [.
...
done]
( 7/34) Installing: libbrotlicommon1-1.0.2-lp151.2.3.x86_64 [.
......
done]
( 8/34) Installing: libdb-4_8-4.8.30-lp151.6.70.x86_64 [.
..
.
.
.
.
..
.
.
.
done]
( 9/34) Installing: libdbus-1-3-1.12.2-lp151.3.24.x86_64 [.
.
..
.....
done]
(10/34) Installing: libdevmapper1_03-1.02.149-lp151.3.1.x86_64 [.
.
..
...
..
done]
(11/34) Installing: libexpat1-2.2.5-lp151.2.4.x86_64 [.
....
....
done]
(12/34) Installing: libjson-c3-0.13-lp151.2.3.x86_64 [.
.
...
done]
(13/34) Installing: libkmod2-25-lp151.6.1.x86_64 [.
.
.......
done]
(14/34) Installing: libqrencode4-4.0.0-lp151.2.3.x86_64 [.
....
done]
(15/34) Installing: libseccomp2-2.3.2-lp151.2.3.x86_64 [.
..........
done]
(16/34) Installing: pam-config-0.96-lp151.1.2.x86_64 [.
.
..
.
...
...
done]
Additional rpm output:
*** write_config (account, /etc/pam.d/common-account-pc, ...)
**** write config for pam_access.so (account, disabled)
**** write config for pam_unix2.so (account, disabled)
**** write config for pam_unix.so (account, enabled)
**** write config for pam_krb5.so (account, disabled)
**** write config for pam_localuser.so (account, disabled)
**** write config for pam_sss.so (account, disabled)
**** write config for pam_ldap.so (account, disabled)
**** write config for pam_nam.so (account, disabled)
**** write config for pam_winbind.so (account, disabled)
**** write config for pam_time.so (account, disabled)
*** write_config (auth, /etc/pam.d/common-auth-pc, ...)
**** write config for pam_env.so (auth, enabled)
**** write config for pam_group.so (auth, disabled)
**** write config for pam_pkcs11.so (auth, disabled)
**** write config for pam_fp.so (auth, disabled)
**** write config for pam_fprint.so (auth, disabled)
**** write config for pam_fprintd.so (auth, disabled)
**** write config for pam_thinkfinger.so (auth, disabled)
**** write config for pam_gnome_keyring.so (auth, disabled)
**** write config for pam_kwallet5.so (auth, disabled)
**** write config for pam_ssh.so (auth, disabled)
**** write config for pam_unix2.so (auth, disabled)
**** write config for pam_unix.so (auth, enabled)
**** write config for pam_ecryptfs.so (auth, disabled)
**** write config for pam_krb5.so (auth, disabled)
**** write config for pam_sss.so (auth, disabled)
**** write config for pam_ldap.so (auth, disabled)
**** write config for pam_nam.so (auth, disabled)
**** write config for pam_winbind.so (auth, disabled)
*** write_config (password, /etc/pam.d/common-password-pc, ...)
**** write config for pam_winbind.so (password, disabled)
**** write config for pam_pwcheck.so (password, disabled)
**** write config for pam_passwdqc.so (password, disabled)
**** write config for pam_cracklib.so (password, enabled)
**** write config for pam_pwhistory.so (password, disabled)
**** write config for pam_gnome_keyring.so (password, disabled)
**** write config for pam_kwallet5.so (password, disabled)
**** write config for pam_ecryptfs.so (password, disabled)
**** write config for pam_unix2.so (password, disabled)
**** write config for pam_unix.so (password, enabled)
**** write config for pam_make.so (password, disabled)
**** write config for pam_exec.so (password, disabled)
**** write config for pam_krb5.so (password, disabled)
**** write config for pam_sss.so (password, disabled)
**** write config for pam_ldap.so (password, disabled)
**** write config for pam_nam.so (password, disabled)
*** write_config (session, /etc/pam.d/common-session-pc, ...)
**** write config for pam_selinux.so (session, disabled)
**** write config for pam_mkhomedir.so (session, disabled)
**** write config for pam_systemd.so (session, disabled)
**** write config for pam_limits.so (session, enabled)
**** write config for pam_unix2.so (session, disabled)
**** write config for pam_unix.so (session, enabled)
**** write config for pam_apparmor.so (session, disabled)
**** write config for pam_krb5.so (session, disabled)
**** write config for pam_sss.so (session, disabled)
**** write config for pam_ldap.so (session, disabled)
**** write config for pam_winbind.so (session, disabled)
**** write config for pam_nam.so (session, disabled)
**** write config for pam_umask.so (session, enabled)
**** write config for pam_ssh.so (session, disabled)
**** write config for pam_selinux.so (session, disabled)
**** write config for pam_gnome_keyring.so (session, disabled)
**** write config for pam_kwallet5.so (session, disabled)
**** write config for pam_exec.so (session, disabled)
**** write config for pam_ecryptfs.so (session, disabled)
**** write config for pam_env.so (session, enabled)
(17/34) Installing: pkg-config-0.29.2-lp151.2.70.x86_64 [.
.....
...
..
done]
(18/34) Installing: system-user-wwwrun-20170617-lp151.4.70.noarch [.
.
...done]
Additional rpm output:
groupadd -r www
useradd -r -s /sbin/nologin -c "WWW daemon apache" -U -d /var/lib/wwwrun wwwrun
usermod -a -G www wwwrun
(19/34) Installing: systemd-presets-common-SUSE-15-lp151.7.1.noarch [.
.
.
....done]
(20/34) Installing: which-2.21-lp151.3.70.x86_64 [.
.
....
done]
(21/34) Installing: sysvinit-tools-2.88+-lp151.2.3.x86_64 [.
.
...
.....
.
done]
(22/34) Installing: kbd-2.0.4-lp151.8.1.x86_64 [.
.
..
.
.
.
.
.
.
.
.
.
done]
Additional rpm output:
Updating /etc/sysconfig/console ...
Updating /etc/sysconfig/keyboard ...
(23/34) Installing: libbrotlienc1-1.0.2-lp151.2.3.x86_64 [.
...
...
...
.
done]
(24/34) Installing: libapr-util1-1.6.1-lp151.4.2.x86_64 [.
...
.....
.
done]
(25/34) Installing: dbus-1-1.12.2-lp151.3.24.x86_64 [.
.
...
..
.
.
..
.
done]
Additional rpm output:
update-alternatives: using /usr/bin/dbus-launch.nox11 to provide /usr/bin/dbus-launch (dbus-launch) in auto mode
(26/34) Installing: libcryptsetup12-2.0.5-lp151.1.17.x86_64 [.
..
..
....
done]
(27/34) Installing: systemd-presets-branding-openSUSE-12.2-lp151.13.2.noarch [.
.
.
...done]
(28/34) Installing: systemd-234-lp151.25.7.x86_64 [.
.
..
.
.
.
.
.
.
.
.
.
done]
Additional rpm output:
Creating group systemd-journal with gid 484.
Creating group systemd-timesync with gid 483.
Creating user systemd-timesync (systemd Time Synchronization) with uid 483 and gid 483.
Creating group systemd-coredump with gid 482.
Creating user systemd-coredump (systemd Core Dumper) with uid 482 and gid 482.
Creating group systemd-network with gid 481.
Creating user systemd-network (systemd Network Management) with uid 481 and gid 481.
Failed to connect to bus: No such file or directory
[/usr/lib/tmpfiles.d/journal-nocow.conf:26] Failed to resolve specifier: uninitialized /etc detected, skipping
All rules containing unresolvable specifiers will be skipped.
[/usr/lib/tmpfiles.d/tmp.conf:13] Duplicate line for path "/var/tmp", ignoring.
[/usr/lib/tmpfiles.d/var.conf:21] Duplicate line for path "/var/lib", ignoring.
[/usr/lib/tmpfiles.d/var.conf:23] Duplicate line for path "/var/spool", ignoring.
Created symlink /etc/systemd/system/multi-user.target.wants/remote-fs.target -> /usr/lib/systemd/system/remote-fs.target.
Created symlink /etc/systemd/system/getty.target.wants/getty@tty1.service -> /usr/lib/systemd/system/getty@.service.
Removed /etc/systemd/system/dbus-org.freedesktop.network1.service.
(29/34) Installing: udev-234-lp151.25.7.x86_64 [.
.
..
.
.
.
.
.
.
..
.
done]
(30/34) Installing: xz-5.2.3-lp151.4.3.1.x86_64 [.
.
.....
....
done]
(31/34) Installing: apache2-utils-2.4.33-lp151.8.3.1.x86_64 [.
.
......
.
done]
(32/34) Installing: logrotate-3.13.0-lp151.4.2.x86_64 [.
.
...
..
.
done]
Additional rpm output:
Failed to connect to bus: No such file or directory
Created symlink /etc/systemd/system/timers.target.wants/logrotate.timer -> /usr/lib/systemd/system/logrotate.timer.
(33/34) Installing: apache2-2.4.33-lp151.8.3.1.x86_64 [.
.
..
.
.
.
.
.
.
.
.
.
done]
Additional rpm output:
Updating /etc/sysconfig/apache2 ...
Failed to connect to bus: No such file or directory
(34/34) Installing: apache2-prefork-2.4.33-lp151.8.3.1.x86_64 [.
.
.
..
..
..
.
done]
Executing %posttrans script 'blog-2.18-lp151.5.3.x86_64.rpm' [..
.
.
Output of systemd-presets-common-SUSE-15-lp151.7.1.noarch.rpm %posttrans script:
Created symlink /etc/systemd/system/default.target.wants/ca-certificates.path -> /usr/lib/systemd/system/ca-certificates.path.
Created symlink /etc/systemd/system/multi-user.target.wants/kbdsettings.service -> /usr/lib/systemd/system/kbdsettings.service.
.
.
.
.
Output of udev-234-lp151.25.7.x86_64.rpm %posttrans script:
Creating /lib/udev -> /usr/lib/udev symlink.
.
.
..done]
Removing intermediate container 27ca7ab6aad0
---> a8843390fc11
Step 5/8 : RUN zypper -n update && zypper -n install php7 php7-mysql apache2-mod_php7
---> Running in 71d768b7e7c6
Loading repository data...
Reading installed packages...
Nothing to do.
Loading repository data...
Reading installed packages...
Resolving package dependencies...
The following 13 NEW packages are going to be installed:
apache2-mod_php7 iproute2 libicu60_2 libicu60_2-ledata libmnl0 libxtables12 php7 php7-mysql php7-pdo postfix system-user-mail system-user-nobody timezone
13 new packages to install.
Overall download size: 13.3 MiB. Already cached: 0 B. After the operation, additional 55.8 MiB will be used.
Continue? [y/n/v/...? shows all options] (y): y
Retrieving package libicu60_2-ledata-60.2-lp151.2.4.noarch (1/13), 6.2 MiB ( 25.7 MiB unpacked)
Retrieving: libicu60_2-ledata-60.2-lp151.2.4.noarch.rpm [
.
done]
Retrieving package libmnl0-1.0.4-lp151.2.2.x86_64 (2/13), 16.4 KiB ( 22.4 KiB unpacked)
Retrieving: libmnl0-1.0.4-lp151.2.2.x86_64.rpm [
done]
Retrieving package libxtables12-1.6.2-lp151.2.3.x86_64 (3/13), 38.1 KiB ( 50.9 KiB unpacked)
Retrieving: libxtables12-1.6.2-lp151.2.3.x86_64.rpm [
done]
Retrieving package system-user-mail-20170617-lp151.4.70.noarch (4/13), 10.3 KiB ( 86 B unpacked)
Retrieving: system-user-mail-20170617-lp151.4.70.noarch.rpm [
done]
Retrieving package system-user-nobody-20170617-lp151.4.70.noarch (5/13), 10.4 KiB ( 116 B unpacked)
Retrieving: system-user-nobody-20170617-lp151.4.70.noarch.rpm [
.
done]
Retrieving package timezone-2019a-lp151.1.1.x86_64 (6/13), 414.7 KiB ( 1.2 MiB unpacked)
Retrieving: timezone-2019a-lp151.1.1.x86_64.rpm [
done]
Retrieving package iproute2-4.12-lp151.6.1.x86_64 (7/13), 766.9 KiB ( 2.0 MiB unpacked)
Retrieving: iproute2-4.12-lp151.6.1.x86_64.rpm [
done]
Retrieving package libicu60_2-60.2-lp151.2.4.x86_64 (8/13), 1.5 MiB ( 4.8 MiB unpacked)
Retrieving: libicu60_2-60.2-lp151.2.4.x86_64.rpm [
.
done (15.6 MiB/s)]
Retrieving package postfix-3.3.1-lp151.2.3.1.x86_64 (9/13), 1.1 MiB ( 3.2 MiB unpacked)
Retrieving: postfix-3.3.1-lp151.2.3.1.x86_64.rpm [
done]
Retrieving package php7-7.2.5-lp151.6.3.1.x86_64 (10/13), 1.6 MiB ( 9.5 MiB unpacked)
Retrieving: php7-7.2.5-lp151.6.3.1.x86_64.rpm [
done]
Retrieving package php7-pdo-7.2.5-lp151.6.3.1.x86_64 (11/13), 63.3 KiB (123.7 KiB unpacked)
Retrieving: php7-pdo-7.2.5-lp151.6.3.1.x86_64.rpm [
done]
Retrieving package php7-mysql-7.2.5-lp151.6.3.1.x86_64 (12/13), 65.1 KiB (162.3 KiB unpacked)
Retrieving: php7-mysql-7.2.5-lp151.6.3.1.x86_64.rpm [
done]
Retrieving package apache2-mod_php7-7.2.5-lp151.6.3.1.x86_64 (13/13), 1.5 MiB ( 9.2 MiB unpacked)
Retrieving: apache2-mod_php7-7.2.5-lp151.6.3.1.x86_64.rpm [
done]
Checking for file conflicts: [..
.
....
.done]
( 1/13) Installing: libicu60_2-ledata-60.2-lp151.2.4.noarch [.
.
.
.
.
.
.
.
.
.
.
.
done]
( 2/13) Installing: libmnl0-1.0.4-lp151.2.2.x86_64 [.
.
..
done]
( 3/13) Installing: libxtables12-1.6.2-lp151.2.3.x86_64 [.
.
...
done]
( 4/13) Installing: system-user-mail-20170617-lp151.4.70.noarch [.
.
..
..done]
Additional rpm output:
useradd -r -s /sbin/nologin -c "Mailer daemon" -U -d /var/spool/clientmqueue mail
groupadd -r mail
( 5/13) Installing: system-user-nobody-20170617-lp151.4.70.noarch [.
.
.
...done]
Additional rpm output:
groupadd -r -g 65533 nogroup
groupadd -r -g 65534 nobody
useradd -r -s /sbin/nologin -c "nobody" -g nobody -d /var/lib/nobody -u 65534 nobody
usermod -a -G nogroup nobody
( 6/13) Installing: timezone-2019a-lp151.1.1.x86_64 [.
.
.
.
.
.
.
.
.
.
.
.
done]
Additional rpm output:
warning: /etc/localtime created as /etc/localtime.rpmnew
( 7/13) Installing: iproute2-4.12-lp151.6.1.x86_64 [.
.
.
.
.
...
..
.
.
done]
( 8/13) Installing: libicu60_2-60.2-lp151.2.4.x86_64 [.
.
.
.
.
.
.
.
.
.
.
.
done]
( 9/13) Installing: postfix-3.3.1-lp151.2.3.1.x86_64 [.
.
.
..
.
.
.
.
.
.
.
.
done]
Additional rpm output:
Failed to connect to bus: No such file or directory
Created symlink /etc/systemd/system/multi-user.target.wants/postfix.service -> /usr/lib/systemd/system/postfix.service.
Updating /etc/sysconfig/postfix ...
Updating /etc/sysconfig/mail ...
(10/13) Installing: php7-7.2.5-lp151.6.3.1.x86_64 [.
.
.
.
.
.
.
.
.
.
.
.
done]
(11/13) Installing: php7-pdo-7.2.5-lp151.6.3.1.x86_64 [.
..
....
done]
(12/13) Installing: php7-mysql-7.2.5-lp151.6.3.1.x86_64 [.
....
...
done]
(13/13) Installing: apache2-mod_php7-7.2.5-lp151.6.3.1.x86_64 [.
.
.
.
.
.
.
.
.
.
.
.
done]
Executing %posttrans script 'apache2-mod_php7-7.2.5-lp151.6.3.1.x86_64.rpm' [..
..done]
Removing intermediate container 71d768b7e7c6
---> 603836f07303
Step 6/8 : RUN a2enmod php7
---> Running in a94cefc32402
Removing intermediate container a94cefc32402
---> 6b7c3bb380dc
Step 7/8 : RUN echo "Welcome to virtualapps/opensuse-apache2, copy your web pages to /srv/www/htdocs/" > /srv/www/htdocs/index.html
---> Running in 4bfa68fc6670
Removing intermediate container 4bfa68fc6670
---> 84d6011c2bc8
Step 8/8 : CMD ["apache2ctl", "-D FOREGROUND"]
---> Running in 537a40663623
Removing intermediate container 537a40663623
---> 7114b1bb48af
Successfully built 7114b1bb48af
Successfully tagged nu11secur1ty/suse-apache-docker-php7:latest
Pushing index.docker.io/nu11secur1ty/suse-apache-docker-php7:latest...
Done!
Build finished
```

# Good luck to everyone! ;)
