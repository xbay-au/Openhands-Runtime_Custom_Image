
# Use a slim Debian base image
FROM debian:bookworm-slim

LABEL maintainer="Leighton <linux@clucas.au>"
LABEL description="Custom Docker image for OpenHands with Go, Node.js, Python, Nmap, and Subfinder"
LABEL version="1.0"
LABEL usage="docker build -t custom-image ."

# Update and install necessary packages in a single layer
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
    liblzma-dev \
    python3-pip \
    nodejs \
    nmap && \
    rm -rf /var/lib/apt/lists/*

# Install Go
ENV GOLANG_VERSION=1.21.5
ENV GO_DOWNLOAD_URL=https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz

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
ENV PATH="$PATH:$HOME/go/bin"

# Update Nmap scripts
RUN nmap --script-updatedb

# Install lsd (modern ls command)
RUN curl -s https://api.github.com/repos/lsd-rs/lsd/releases/latest | grep browser_download_url | grep linux-musl | cut -d '"' -f 4 | wget -qi - && \
    tar xzf lsd*tar.gz --strip-components=1 -C /usr/local/bin && \
    rm lsd*tar.gz

# Set working directory for git clone operations
WORKDIR /opt/reconftw
