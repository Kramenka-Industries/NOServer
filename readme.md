# NOServer - Dockerized Nuclear Option Dedicated Server

This repository builds a container image for the Nuclear Option dedicated server and now includes a Helm chart for Kubernetes deployment.

Official server tools documentation: [Shockfront-Studios/Nuclear-Option-Server-Tools](https://github.com/Shockfront-Studios/Nuclear-Option-Server-Tools)

## Build the image

Use the streamlined build script:

```bash
./build.sh
```

Optional build-time overrides:

```bash
IMAGE_NAME=ghcr.io/your-org/noserver IMAGE_TAG=latest RCON_TOOLS_REF=main ./build.sh
```

The image build now fetches the ServerControlPanel repository directly during `docker build`, so no pre-clone step is required.

## Run with Docker

Use any of the provided scripts (`testRun.sh`, `stressTest.sh`, `runDogfight.sh`, `runPvE.sh`, etc.) as examples for local runs.

Important runtime flags:

```text
--password
--rconPassword
--portValue
--queryValue
--rconPort
--internalRconPort
```

Do not run with default credentials.

## Deploy on Kubernetes (Helm)

Chart location:

```text
helm/noserver
```

Install with default values:

```bash
helm upgrade --install noserver ./helm/noserver
```

Install with custom image and persistence:

```bash
helm upgrade --install noserver ./helm/noserver \
  --set image.repository=ghcr.io/your-org/noserver \
  --set image.tag=latest \
  --set persistence.enabled=true \
  --set service.type=LoadBalancer
```

Main configurable areas in `helm/noserver/values.yaml`:

- image repository/tag/pull policy
- service type and game/query/rcon ports
- persistence (emptyDir vs PVC)
- server arguments (name, modded, limits, rotation)

## Volumes used by the container

```text
/replays
/missions
/banlist
/serverlog
```

- `/replays`: Tacview exports
- `/missions`: mission directory (defaults to built-in rotation if empty)
- `/banlist`: ban list file location
- `/serverlog`: dedicated server logs
