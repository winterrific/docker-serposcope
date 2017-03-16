FROM java:8u72-jre
MAINTAINER Carles Amigó, fr3nd@fr3nd.net

RUN apt-get update && apt-get install -y \
      curl \
      && rm -rf /usr/share/doc/* && \
      rm -rf /usr/share/info/* && \
      rm -rf /tmp/* && \
      rm -rf /var/tmp/*

ENV SERPOSCOPE_VERSION 2.7.0

RUN mkdir -p /opt/serposcope /var/log/serposcope /var/lib/serposcope/
RUN curl -L https://serposcope.serphacker.com/beta/${SERPOSCOPE_VERSION}/serposcope-${SERPOSCOPE_VERSION}.jar > /opt/serposcope.jar
RUN useradd -u 1000 -d /home/serposcope -m serposcope
COPY serposcope.conf /etc/serposcope.conf
RUN chown serposcope:serposcope /var/log/serposcope /var/lib/serposcope/ /etc/serposcope.conf
COPY entrypoint.sh /usr/local/bin/

EXPOSE 7134

USER serposcope

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
