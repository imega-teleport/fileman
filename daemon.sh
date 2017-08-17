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
            myhost=$(echo $DB_HOST | cut -d ':' -f1)
            myport=$(echo $DB_HOST | cut -d ':' -f2)
            name=$(echo $UUID | sed -e "s/-/_/g")
            mysql --host=$myhost --port=$myport -e "CREATE DATABASE IF NOT EXISTS $name CHARACTER SET utf8 COLLATE utf8_general_ci;"
            mysql --host=$myhost --port=$myport --database=$name -e "source /app/schema.sql;"
            xml2db --db $name --file /data/parse/$UUID/$FILE

            mkdir -p /tmp/$UUID
            db2file --db $name --path /tmp/$UUID
            COMPLETE=$?
            if [ $COMPLETE -eq 0 ];then
                mysql --host=$myhost --port=$myport -e "DROP DATABASE IF EXISTS $name;"
                rsync --inplace -av /tmp/$UUID rsync://storage:873/storage
            fi

            rm -rf /tmp/$UUID
        ;;
    esac
done
