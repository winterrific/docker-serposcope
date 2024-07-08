FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
      curl \
      && apt-get clean cache

ENV SERPOSCOPE_VERSION 3.4

RUN mkdir -p /opt/serposcope /var/log/serposcope /var/lib/serposcope/
RUN curl -L https://www.serposcope.com/downloads/${SERPOSCOPE_VERSION}/serposcope_${SERPOSCOPE_VERSION}_amd64.deb
RUN dpkg -i serposcope_${SERPOSCOPE_VERSION}_amd64.deb
RUN useradd -u 1000 -d /home/serposcope -m serposcope
RUN chown serposcope:serposcope /var/log/serposcope /var/lib/serposcope/ /etc/serposcope.conf
COPY entrypoint.sh /usr/local/bin/

EXPOSE 6333

USER serposcope

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
