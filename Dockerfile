FROM alpine:3.6
MAINTAINER Dmitry Gavriloff <info@imega.ru>
EXPOSE 873

COPY build/ /usr/local/sbin
COPY rsyncd.conf /etc/rsyncd.conf
COPY daemon.sh /app/daemon.sh
COPY wait-list.txt /app/wait-list.txt

RUN apk --upd --no-cache add rsync inotify-tools unzip mariadb-client

CMD ["/app/daemon.sh"]
