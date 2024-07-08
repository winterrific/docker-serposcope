FROM ubuntu:24.04
ENV SERPOSCOPE_VERSION 3.4

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://www.serposcope.com/downloads/${SERPOSCOPE_VERSION}/serposcope_${SERPOSCOPE_VERSION}_amd64.deb -O serposcope.deb && \
    dpkg -i serposcope.deb && \
    rm serposcope.deb

COPY application.conf /usr/share/serposcope
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /usr/share/serposcope/

RUN mkdir -p ./db

VOLUME ["/usr/share/serposcope/db"]
EXPOSE 6333
USER root

ENTRYPOINT ["/entrypoint.sh"]


