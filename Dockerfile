FROM steamcmd/steamcmd:latest

ARG DEBIAN_FRONTEND=noninteractive
ARG STEAM_APP_ID=3930080
ARG RCON_TOOLS_REPO=https://github.com/Shockfront-Studios/Nuclear-Option-Server-Tools.git
ARG RCON_TOOLS_REF=main

ENV TZ=Europe/Zurich \
    SERVER_DIR=/server \
    RCON_DIR=/rcon \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    file \
    git \
    jq \
    python3 \
    python3-flask \
    python3-pip \
    python3-venv \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN steamcmd +force_install_dir "${SERVER_DIR}" +login anonymous +app_update "${STEAM_APP_ID}" validate +quit
RUN git clone --depth 1 --branch "${RCON_TOOLS_REF}" "${RCON_TOOLS_REPO}" "${RCON_DIR}"

WORKDIR /
COPY entrypoint.sh entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY bepinex_preconfig/run_bepinex.sh server/run_bepinex.sh
RUN chmod +x server/run_bepinex.sh

VOLUME ["/replays"]
VOLUME ["/missions"]
VOLUME ["/banlist"]
VOLUME ["/serverlog"]
VOLUME ["/server/BepInEx/plugins"]

ENTRYPOINT ["/entrypoint.sh"]
