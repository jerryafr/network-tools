#!/bin/bash

#declare -A RESULTS
HOSTS=("google.com" "facebook.com" "wikipedia.org" "youtube.com" "amazon.com" "telegram.org")
SUCCESS=1

for HOST in "${HOSTS[@]}"
do
    ping -c 1 -W 1 "$HOST" > /dev/null 2>&1 &
    PING_PID=$!
    HOST_PIDS["$PING_PID"]=$HOST
done

UPDATED_HOSTS=()
RESULTS=()
for PID in "${!HOST_PIDS[@]}"
do
    UPDATED_HOSTS+=(${HOST_PIDS[$PID]})
    wait $PID
    if [ $? -eq 0 ]; then
        RESULTS+=(true)
        SUCCESS=0
    else
        RESULTS+=(false)
    fi
done

if [ $SUCCESS -eq 0 ]; then
    echo "{ success: true , results: {\"${UPDATED_HOSTS[0]}\":${RESULTS[0]}, \"${UPDATED_HOSTS[1]}\":${RESULTS[1]}, \"${UPDATED_HOSTS[2]}\":${RESULTS[2]}, \"${UPDATED_HOSTS[3]}\":${RESULTS[3]}, \"${UPDATED_HOSTS[4]}\":${RESULTS[4]}, \"${UPDATED_HOSTS[5]}\":${RESULTS[5]} } }"
    exit 0
else
    echo "{ success: false }"
    exit 1
fi