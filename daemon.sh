#!/bin/sh

/usr/bin/rsync --no-detach --daemon --config /etc/rsyncd.conf &

inotifywait -mr -e close_write --fromfile /app/wait-list.txt | while read DEST EVENT FILE
do
    SERVICE=`echo $DEST | cut -d"/" -f3`
    UUID=`echo $(basename "$DEST")`
    case "$SERVICE" in
        "zip")
            UUID=`echo $(basename "$DEST")`
            mkdir -p /data/parse/$UUID
            unzip $DEST$FILE -d /data/parse/$UUID
        ;;
        "parse")
            echo parse111
        ;;
    esac
done
