FROM alpine:3.10.2 AS dev
WORKDIR /tmp
ADD databases.tgz expeditionML-dependencies_0.1.3-h2.tar.gz expedition_1.1.38.tar.gz mariadb-server.cnf install.sh /tmp/
ADD dpkg.log /var/log/
ADD apt dpkg /usr/bin/
RUN ./install.sh

FROM dev AS prod
WORKDIR /
ADD start.sh stop.sh /
CMD ["sh","-c","./start.sh && tail -f /dev/null"]
