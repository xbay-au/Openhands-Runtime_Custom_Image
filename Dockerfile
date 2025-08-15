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
RUN set -x && \
    retry_count=3 && \
    while [ $retry_count -gt 0 ]; do \
        apt-get update && \
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
            libcurl4-openssl-dev \
            libxml2 \
            libxml2-dev \
            libxslt1-dev \
            ruby-dev \
            libgmp-dev \
            xz-utils \
            apt-utils \
            tk-dev \
            libffi-dev \
            iputils-ping \
            dirb \
            liblzma-dev \
            dnsutils \
            nikto \
            whois && \
        rm -rf /var/lib/apt/lists/* && \
        break || echo "Installation failed. Retrying..." && retry_count=$((retry_count - 1)) && sleep 5; \
    done && \
    [ $retry_count -gt 0 ] || exit 1

# Install programming languages and related tools
RUN set -x && \
    retry_count=3 && \
    while [ $retry_count -gt 0 ]; do \
        apt-get update && \
        apt-get install -y --no-install-recommends \
            python3-pip \
            nodejs \
            npm \
            ruby \
            php \
            openjdk-17-jdk \
            nano && \
        rm -rf /var/lib/apt/lists/* && \
        break || echo "Installation failed. Retrying..." && retry_count=$((retry_count - 1)) && sleep 5; \
    done

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
RUN set -x && \
    retry_count=3 && \
    while [ $retry_count -gt 0 ]; do \
        apt-get update && \
        apt-get install -y --no-install-recommends lsd && \
        rm -rf /var/lib/apt/lists/* && \
        break || echo "Installation failed. Retrying..." && retry_count=$((retry_count - 1)) && sleep 5; \
    done

# Install Security Tools
RUN gem install wpscan && \
    set -x && \
    retry_count=3 && \
    while [ $retry_count -gt 0 ]; do \
        apt-get update && \
        apt-get install -y --no-install-recommends nmap && \
        rm -rf /var/lib/apt/lists/* && \
        break || echo "Installation failed. Retrying..." && retry_count=$((retry_count - 1)) && sleep 5; \
    done && \
    mkdir -p /usr/share/nmap/nselib/ && \
    nmap --script-updatedb

# Install projectdiscovery subfinder (security tool)
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && \
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

# Install Hakluke Repo's
RUN go install github.com/hakluke/hakrawler@latest && \
    go install github.com/hakluke/hakrevdns@latest && \
    go install github.com/hakluke/haklistgen@latest && \
    go install github.com/hakluke/hakoriginfinder@latest && \
    go install github.com/hakluke/hakcheckurl@latest && \
    go install -v github.com/hakluke/haktrails@latest && \
    go install github.com/hakluke/haktldextract@latest && \
    go install github.com/hakluke/hakip2host@latest

ENV PATH="${PATH}:/usr/local/bin"

# Verify Nikto installation
RUN nikto -h || true  # Use `|| true` to prevent build failure if command is not found during verification.

# Install Docker binaries
RUN set -x && \
    retry_count=3 && \
    while [ $retry_count -gt 0 ]; do \
        apt-get update && \
        apt-get install -y --no-install-recommends \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg \
            lsb-release && \
        rm -rf /var/lib/apt/lists/* && \
        mkdir -p /etc/apt/keyrings && \
        curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
        apt-get update && \
        apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io && \
        rm -rf /var/lib/apt/lists/* && \
        break || echo "Installation failed. Retrying..." && retry_count=$((retry_count - 1)) && sleep 5; \
    done

# Install ffuf
RUN go install github.com/ffuf/ffuf/v2@latest

# Install assetfinder
RUN go install github.com/tomnomnom/assetfinder@latest

# Install waybackurls
RUN go install github.com/tomnomnom/waybackurls@latest
