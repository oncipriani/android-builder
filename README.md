# Android Open Source Project (AOSP) Build Environment

A [Docker](https://www.docker.com/) container that provides the
[required](http://source.android.com/source/requirements.html) environment for
building the [AOSP](http://source.android.com/index.html).

Developers can use the Docker image to build directly while running their
distribution of choice, without having to worry about breaking the delicate AOSP
build due to package updates as is sometimes common on bleeding edge rolling
distributions like [Arch Linux](https://www.archlinux.org/).

Production build servers and integration test servers should also use the same
Docker image and environment. This eliminates most surprise breakages by
empowering developers and production builds to use the exact same environment.
The devs will catch the issues with build environment first.

## Quick Start

1. Build the container image;
2. Create a directory where the AOSP source and builds will be stored;
3. Run the container, mounting the directory created above at "/aosp";
4. Follow the instructions from the AOSP source site, starting from `repo init`:
  - http://source.android.com/source/downloading.html#initializing-a-repo-client

## Customizing the Container Image

All builds inside the container are performed by the "aosp" user. The _UID_,
_GID_, _name_ and _e-mail_ of that user should be the same as the user running
the container, although it is not required.

If you need or want to change those attributes, you can do so at build time
without changing the Dockerfile using the `--build-arg` parameter:

```
docker build \
  --build-arg=AOSP_GID=1000 \
  --build-arg=AOSP_UID=1000 \
  --build-arg=AOSP_NAME="My Name" \
  --build-arg=AOSP_EMAIL="myemail@example.com" \
  --tag=docker-aosp /path/containing/the/Dockerfile
```
