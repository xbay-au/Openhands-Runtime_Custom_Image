# Use a slim Debian base image for minimal footprint
# FROM debian:bookworm-slim
# FROM debian:bookworm-slim
FROM nikolaik/python-nodejs:python3.12-nodejs22

# Metadata labels for the Docker image
LABEL maintainer="Leighton <linux@clucas.au>"
LABEL description="Custom Docker image for OpenHands with Go, Node.js, Python, Nmap, Subfinder, Ruby, PHP, Java, and more"
LABEL version="1.3"
LABEL usage="docker build -t custom-image ."
LABEL url="https://github.com/xbay-au/Openhands-Runtime_Custom_Image"

# Set environment variables for non-interactive installs
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install essential tools in separate layers for better caching
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash \
    curl \
    wget \
    git \
    ca-certificates \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    apt-utils
    tk-dev \
    libffi-dev \
    liblzma-dev && \
    rm -rf /var/lib/apt/lists/

# Install programming languages and related tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3-pip \
    nodejs \
    npm \
    ruby \
    php \
    openjdk-17-jdk \
    nano && \
    rm -rf /var/lib/apt/lists/

# Install security tools section has been removed temporarily

# Install Go with retry logic for download failures
ENV GOLANG_VERSION=1.21.5
ENV GO_DOWNLOAD_URL=https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz

RUN set -x && \
    retry_count=3 && \
    while [ $retry_count -gt 0 ]; do \
        wget -q --no-check-certificate "$GO_DOWNLOAD_URL" -O /tmp/go.tar.gz && \
        tar -C /usr/local -xzf /tmp/go.tar.gz && \
        rm /tmp/go.tar.gz && \
        break || echo "Download failed. Retrying..." && retry_count=$((retry_count - 1)) && sleep 5; \
    done && \
    [ $retry_count -gt 0 ] || exit 1

# Set up Go environment
ENV PATH="/usr/local/go/bin:$PATH"

# Add Go binaries to PATH
RUN mkdir -p /root/go/bin
ENV PATH="$PATH:/root/go/bin"

# Install lsd (modern ls command)
RUN apt-get update && \
    apt-get install -y --no-install-recommends lsd && \
    rm -rf /var/lib/apt/lists*

# Install Security Tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends nmap && \
    rm -rf /var/lib/apt/lists/

# Fetch latest NSE scripts from upstream repository
RUN mkdir -p /usr/share/nmap/nselib/ && \
    nmap --script-updatedb

# Install projectdiscovery subfinder (security tool)
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# Install Hakluke Repo's
RUN go install github.com/hakluke/hakrawler@latest
RUN go install github.com/hakluke/hakrevdns@latest
RUN go install github.com/hakluke/haklistgen@latest
RUN go install github.com/hakluke/hakoriginfinder@latest
RUN go install github.com/hakluke/hakcheckurl@latest
RUN go install -v github.com/hakluke/haktrails@latest
RUN go install github.com/hakluke/haktldextract@latest
RUN go install github.com/hakluke/hakip2host@latest
#RUN go install github.com/hakluke/hakfindinternaldomains

# TODO:
# 1. Add more security tools as needed
# 2. Review and optimize package installations for better caching
# 3. Consider adding additional programming languages if required by projects

# Install nikto security scanner
# RUN apt-get update && \
#   apt add --no-cache nikto perl-net-ssleay && \
#   rm -rf /var/lib/apt/lists/*
