#!/bin/bash

DEVICES=$(jq --raw-output '.devices[]' /data/options.json)

if [ -f /data/adbkey ]; then
  cp /data/adbkey /root/.android && cp /data/adbkey.pub /root/.android
fi

nohup adb -a -P 5037 server nodaemon &

sleep 30

if [ ! -f /data/adbkey ]; then
  cp /root/.android/adbkey /data/adbkey && cp /root/.android/adbkey.pub /data/adbkey.pub
fi


while true; do
  for device in $DEVICES; do
    adb -P 5037 -H 172.17.0.1 connect $device
  done
  sleep 60
done