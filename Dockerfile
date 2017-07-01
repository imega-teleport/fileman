FROM alpine:3.6

COPY build/ /usr/local/sbin

RUN apk --upd --no-cache add rsync inotify-tools unzip
