# BUILD THE SERVER IMAGE
FROM --platform=linux/amd64 debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    unzip \
    libicu-dev \
    gettext-base \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install .NET 8 runtime (required for DepotDownloader)
RUN curl -sL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh && \
    chmod +x /tmp/dotnet-install.sh && \
    /tmp/dotnet-install.sh --channel 8.0 --runtime dotnet --install-dir /usr/share/dotnet && \
    ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet && \
    rm /tmp/dotnet-install.sh

# Download DepotDownloader
ARG DEPOT_DOWNLOADER_VERSION=3.4.0
RUN curl -sL "https://github.com/SteamRE/DepotDownloader/releases/download/DepotDownloader_${DEPOT_DOWNLOADER_VERSION}/DepotDownloader-linux-x64.zip" -o /tmp/dd.zip && \
    mkdir -p /depotdownloader && \
    unzip /tmp/dd.zip -d /depotdownloader && \
    chmod +x /depotdownloader/DepotDownloader && \
    rm /tmp/dd.zip

RUN useradd -m -s /bin/bash steam

ENV HOME=/home/steam \
    UPDATE_ON_START=true \
    AUTO_START_WORLD_NAME="" \
    AUTO_CREATE_AND_LOAD_WORLD=true \
    AUTO_CREATE_WORLD_SIZE=1 \
    AUTO_CREATE_WORLD_SEED=null \
    PASSWORD="" \
    PORT=8050 \
    MAX_PLAYERS=8 \
    ENABLE_CHEATS=false

COPY ./scripts /home/steam/server/
COPY branding /branding

RUN mkdir -p /home/steam/server-files && \
    chmod +x /home/steam/server/*.sh

WORKDIR /home/steam/server

ENTRYPOINT ["/home/steam/server/init.sh"]
