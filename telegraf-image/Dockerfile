FROM telegraf:1.7.0-alpine

RUN apk add --update bash eudev
ADD docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT /docker-entrypoint.sh
ADD telegraf.conf /etc/telegraf/telegraf.conf
