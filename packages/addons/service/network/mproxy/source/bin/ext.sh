#!/bin/sh

ADDON_HOME="$HOME/.xbmc/userdata/addon_data/service.network.mproxy"
ADDON_SETTINGS="$ADDON_HOME/settings.xml"
ADDON_CONFIG_DIR="$ADDON_HOME/config"

GROUP="$1"

URL=$(grep "^$GROUP" "$ADDON_CONFIG_DIR/ext.conf" | awk '{print $2}')

if [ ! "$URL" == "" ] ; then
  case "$2" in
    start)
      if [ ! "$(pidof vlc.bin)" ] ; then
        vlc --http-caching=0 --network-caching=0 --sout-udp-caching=0 \
          "$URL" --ts-out "$GROUP:1234" &
      fi
      ;;
    stop)
      killall -9 vlc.bin
      ;;
  esac
fi
