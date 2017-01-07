#
# Image for building Android Open Source Project (AOSP).
# More information at "http://source.android.com/source/initializing.html".
#
# All builds will be done by the "aosp" user. You should change this user's
# information when building the image to match the user running the container.
#

FROM ubuntu:latest
MAINTAINER Otavio Cipriani <otavio.n.cipriani@gmail.com>

# Information about the "aosp" user
ARG AOSP_GID=1000
ARG AOSP_UID=1000
ARG AOSP_NAME="Android Open Source Project"
ARG AOSP_EMAIL="aosp@localhost.localdomain"

# Install required packages
RUN apt-get update && apt-get install -yq --no-install-recommends bc bison \
  build-essential ccache curl flex gcc-multilib git-core g++-multilib gnupg \
  gperf lib32ncurses5-dev lib32z-dev libc6-dev-i386 libgl1-mesa-dev \
  libx11-dev libxml2-utils openjdk-8-jdk python-networkx rsync unzip \
  x11proto-core-dev xsltproc zip zlib1g-dev

# Add the "repo" tool
ADD https://storage.googleapis.com/git-repo-downloads/repo /usr/local/bin/repo
RUN chmod 0755 /usr/local/bin/repo

# Mount point for the AOSP source tree
VOLUME /aosp

# Create the AOSP user and group
RUN groupadd --gid $AOSP_GID aosp && useradd --create-home --gid aosp \
  --uid $AOSP_UID --comment "AOSP build user" aosp
USER aosp

# Configure git
RUN git config --global color.ui auto && \
  git config --global user.name "$AOSP_NAME" && \
  git config --global user.email "$AOSP_EMAIL"

# Set environment variables required to build AOSP
ENV USER=aosp

# This container should be run interactively
WORKDIR /aosp
ENTRYPOINT [ "/bin/bash" ]
