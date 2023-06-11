#!/bin/bash

HOSTS=("8.8.8.8" "4.2.2.4" "1.1.1.1")
SUCCESS=1

for HOST in "${HOSTS[@]}"
do
    ping -c 1 $HOST &> /dev/null

    if [ $? -eq 0 ]; then
        RESULTS+=(true)
        SUCCESS=0
    else
        RESULTS+=(false)
    fi
done

if [ $SUCCESS -eq 0 ]; then
    echo "{ success: true , results: {\"${HOSTS[0]}\":${RESULTS[0]}, \"${HOSTS[1]}\":${RESULTS[1]}, \"${HOSTS[2]}\":${RESULTS[2]} } }"
    exit 0
else
    echo "{ success: false }"
    exit 1
fi