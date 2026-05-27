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

A Docker container for running a Romestead dedicated server using DepotDownloader.

## Server Requirements

| Resource | Minimum  | Recommended |
|----------|----------|-------------|
| CPU      | 2 cores  | 4+ cores    |
| RAM      | 4GB      | 8GB         |
| Storage  | 10GB     | 20GB        |

## How to use

Copy the `.env.example` file to a new file called `.env`. Then run the container.

### Docker Compose

```yaml
services:
  romestead:
    image: indifferentbroccoli/romestead-server-docker
    restart: unless-stopped
    container_name: romestead
    stop_grace_period: 30s
    ports:
      - 8050:8050/udp
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
  --restart unless-stopped \
    --name romestead \
  --stop-timeout 30 \
  -p 8050:8050/udp \
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
| AUTO_START_WORLD_NAME | (empty)     | `config.json` `AutoStartWorldName` |
| AUTO_CREATE_AND_LOAD_WORLD | true   | `config.json` `AutoCreateAndLoadWorld` |
| AUTO_CREATE_WORLD_SIZE | 1          | `config.json` `AutoCreateWorldSize` |
| AUTO_CREATE_WORLD_SEED | null       | `config.json` `AutoCreateWorldSeed` |
| PASSWORD          | null            | `config.json` `Password` |
| PORT              | 8050            | `config.json` `Port` and container UDP mapping |
| MAX_PLAYERS       | 8               | `config.json` `MaxPlayers` |
| ENABLE_CHEATS     | false           | `config.json` `EnableCheats` |

## Port Forwarding

Forward these ports through your firewall/router:

| Port  | Protocol | Purpose                  |
|-------|----------|--------------------------|
| 8050  | UDP      | Game traffic             |

See [portforward.com](https://portforward.com) for router-specific guides.

## Server Commands

The server accepts commands via stdin. You can send commands using `docker exec`:

```bash
docker exec -i romestead bash -c 'echo "COMMAND" > /tmp/romestead-stdin'
```

| Command           | Description                              |
|-------------------|------------------------------------------|
| `stop`            | Save the world and stop the server       |
| `quickstop`       | Stop the server without saving           |
| `save`            | Save the world                           |
| `quicksave`       | Save the world (quick)                   |
| `list`            | List connected players                   |
| `say <message>`   | Broadcast a message to all players       |
| `kick <player>`   | Kick a player from the server            |
| `ban <player>`    | Ban a player from the server             |
| `unban <player>`  | Unban a player                           |

**Note:** When the container is stopped (`docker stop` or `docker compose down`), the server automatically receives a `stop` command to save the world before shutting down.

## Volumes

- `/home/steam/server-files` - Server installation files, saves, and configuration
