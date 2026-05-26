![marketing_assets_banner](https://github.com/user-attachments/assets/b8b4ae5c-06bb-46a7-8d94-903a04595036)


[![GitHub License](https://img.shields.io/github/license/indifferentbroccoli/romestead-server-docker?style=for-the-badge&color=6aa84f)](LICENSE)
[![GitHub Release](https://img.shields.io/github/v/release/indifferentbroccoli/romestead-server-docker?style=for-the-badge&color=6aa84f)](https://github.com/indifferentbroccoli/romestead-server-docker/releases)
[![GitHub Repo stars](https://img.shields.io/github/stars/indifferentbroccoli/romestead-server-docker?style=for-the-badge&color=6aa84f)](https://github.com/indifferentbroccoli/romestead-server-docker)
[![Discord](https://img.shields.io/discord/798321161082896395?style=for-the-badge&label=Discord&labelColor=5865F2&color=6aa84f)](https://discord.gg/indifferentbroccoli)
[![Docker Pulls](https://img.shields.io/docker/pulls/indifferentbroccoli/romestead-server-docker?style=for-the-badge&color=6aa84f)](https://hub.docker.com/r/indifferentbroccoli/romestead-server-docker)

Game server hosting

Fast RAM, high-speed internet

Eat lag for breakfast

[Try our Romestead server hosting free for 2 days!](https://indifferentbroccoli.com/romestead-server-hosting)

## Romestead Dedicated Server Docker

A Docker container for downloading Romestead dedicated server files using DepotDownloader.

## Server Requirements

| Resource | Minimum  | Recommended |
|----------|----------|-------------|
| CPU      | 2 cores  | 4+ cores    |
| RAM      | 4GB      | 8GB         |
| Storage  | 10GB     | 20GB        |

## How to use

Copy the `.env.example` file to a new file called `.env`. Then run the container to download files.

### Docker Compose

```yaml
services:
  romestead:
    image: indifferentbroccoli/romestead-server-docker
    container_name: romestead
    env_file:
      - .env
    volumes:
      - ./server-files:/home/steam/server-files
```

Then run:

```bash
docker compose up -d
```

### Docker Run

```bash
docker run -d \
    --name romestead \
    --env-file .env \
    -v ./server-files:/home/steam/server-files \
    indifferentbroccoli/romestead-server-docker
```

## Environment Variables

| Variable          | Default         | Info |
|-------------------|-----------------|------|
| PUID              | 1000            | User ID for file permissions |
| PGID              | 1000            | Group ID for file permissions |
| UPDATE_ON_START   | true            | Set to `false` to skip downloading and validating server files on startup |

> [!NOTE]
> Steam app id is fixed to `4763510` in the container scripts.

## Volumes

- `/home/steam/server-files` - Server installation files, saves, and configuration
