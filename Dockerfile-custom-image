

ROM nikolaik/python-nodejs:python3.12-nodejs22

FROM ruby:latest

FROM debian:bookworm-slim


LABEL maintainer="Leighton linux@clucas.au"

#DESCRIPTION:           Create Golang in a container
# AUTHOR:               Leighton <linux@clucas.au>
# COMMENTS:
#       Dockerfile builds a golang docker image within a bash shell.
# USAGE:
#       Download Dockerfile
#       wget https://raw.githubusercontent.com/cbay-au/dockerfiles/main/golang/Dockerfile
#       Build golang image
#       docker build -t golang .
#       docker run -it golang:latest bash
#       test with <go version>
# TODO:
#       1.check wich is the lighest FROM to use
#       2. chech line with ENV seems to be ussing a depreciated syntax

#FROM ubuntu:latest
FROM debian:bookworm-slim

# Update and install necessary packages
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  bash \
  curl \
  wget \
  git \
  ca-certificates \
  --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

# Environment variables
ENV GOLANG_VERSION 1.21.5

# Set the URL for downloading Go
ENV GO_DOWNLOAD_URL https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz

# Attempt to download Go with retries
RUN set -x && \
    retry_count=3 && \
    while [ $retry_count -gt 0 ]; do \
        wget -q --no-check-certificate "$GO_DOWNLOAD_URL" && \
        tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz && \
        rm go${GOLANG_VERSION}.linux-amd64.tar.gz && \
        break || echo "Download failed. Retrying..." && retry_count=$((retry_count - 1)) && sleep 5; \
    done && \
    [ $retry_count -gt 0 ] || exit 1

# Set up Go environment
ENV PATH="/usr/local/go/bin:$PATH"

# Install projectdiscovery subfinder
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
RUN echo export PATH=$PATH:$HOME/go/bin >> $home/.bashrc
RUN . ~/.bashrc

# Set working directory for git clone
WORKDIR /opt/reconftw

RUN apt-get update && \
    apt-get install -y --no-install-recommends nmap && \
    rm -rf /var/lib/apt/lists/*

# Fetch latest NSE scripts from upstream repository
RUN mkdir -p /usr/share/nmap/nselib/ && \
    echo "Updating Network Discovery Scripts..." && \
    nmap --script-updatedb

