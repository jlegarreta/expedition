FROM ubuntu:xenial
RUN apt-get update
RUN apt-get -y install apt-transport-https lsb-core lsb-release net-tools netcat-openbsd sudo
RUN touch /usr/bin/firewall-cmd
RUN chmod +x /usr/bin/firewall-cmd
RUN useradd -m expedition
RUN chmod 755 /root
COPY ./setup /setup
WORKDIR /setup
ENV TERM=xterm
RUN ./initSetup.sh
WORKDIR /
RUN rm -rf /setup /tmp/*
COPY start.sh /
CMD /start.sh
