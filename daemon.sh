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
            unzip -o $DEST$FILE -d /data/parse/$UUID
        ;;
        "parse")
            xml2db --db teleport --file /data/parse/$UUID/$FILE
            mkdir -p /tmp/$UUID
            db2file --db teleport --path /tmp/$UUID
            rsync --inplace -av /tmp/$UUID rsync://storage:873/storage
            rm -rf /tmp/$UUID
        ;;
    esac
done
