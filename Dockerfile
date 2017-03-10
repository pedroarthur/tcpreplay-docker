FROM debian:testing

RUN mkdir -p /usr/local/bin

RUN apt-get update \
  && apt-get install -y libpcap0.8 libopts25

COPY tcpreplay/src/tcpcapinfo     /usr/local/bin
COPY tcpreplay/src/tcpbridge      /usr/local/bin
COPY tcpreplay/src/tcpreplay-edit /usr/local/bin
COPY tcpreplay/src/tcprewrite     /usr/local/bin
COPY tcpreplay/src/tcpliveplay    /usr/local/bin
COPY tcpreplay/src/tcpprep        /usr/local/bin
COPY tcpreplay/src/tcpreplay      /usr/local/bin

CMD [ "/usr/local/bin/tcpreplay-edit" ]

