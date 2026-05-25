QUOTA=1
INDEX=1
SERVERPORT=7787
QUERYPORT=7788
RCONPORT=50004
CPU1=4
CPU2=5
for ((INDEX=1;INDEX<$QUOTA+1;INDEX++)); do
    sudo podman run -d \
        --cpuset-cpus=$CPU1,$CPU2 \
        -p $SERVERPORT-$QUERYPORT:$SERVERPORT-$QUERYPORT/udp \
        -p $SERVERPORT-$QUERYPORT:$SERVERPORT-$QUERYPORT/tcp \
        -p $RCONPORT-$RCONPORT:$RCONPORT-$RCONPORT/tcp \
        -v "$(pwd)/PvEMission":/missions \
        -v "$(pwd)/banlist":/banlist \
        -v "$(pwd)/replays":/replays \
        -v "$(pwd)/serverlog":/serverlog \
        -v "$(pwd)/bepinex/plugins":/server/BepInEx/plugins noserver \
        --modded false \
        --name "BROCCOLI DEFROST FORCE PVE "$INDEX"" \
        --password ""\
        --portOverride true \
        --portValue $SERVERPORT \
        --queryOverride true \
        --queryValue $QUERYPORT \
        --maxplayers 16 \
        --noStopTime 0 \
        --rconPort $RCONPORT \
        --rconPassword "defaultpassword" \
        --fpsLimit 60 \
        --rotationType 2

    ((SERVERPORT=$SERVERPORT + 2))
    ((QUERYPORT=$QUERYPORT + 2))
    ((RCONPORT++))
    ((CPU1=$CPU1+2))
    ((CPU2=$CPU2+2))
done