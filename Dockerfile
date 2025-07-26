# Use a slim Debian base image for minimal footprint
FROM debian:bookworm-slim

# Metadata labels for the Docker image
LABEL maintainer="Leighton <linux@clucas.au>"
LABEL description="Custom Docker image for OpenHands with Go, Node.js, Python, Nmap, Subfinder, Ruby, PHP, Java, and more"
LABEL version="1.3"
LABEL usage="docker build -t custom-image ."
LABEL url="https://github.com/xbay-au/Openhands-custom-image"

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
    tk-dev \
    libffi-dev \
    liblzma-dev && \
    rm -rf /var/lib/apt/lists/*

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
    rm -rf /var/lib/apt/lists/*

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

# Install projectdiscovery subfinder (security tool)
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# Add Go binaries to PATH
RUN mkdir -p /root/go/bin
ENV PATH="$PATH:/root/go/bin"

# Update Nmap scripts
RUN nmap --script-updatedb

# Install lsd (modern ls command)
RUN apt-get update && \
    apt-get install -y --no-install-recommends lsd && \
    rm -rf /var/lib/apt/lists/*

# TODO: Re-add security tools installation
# The following tools were removed due to build issues:
# - nmap, hydra, wget (apt packages)
# - Nikto (from GitHub source)
# - sqlmap (pip package)
