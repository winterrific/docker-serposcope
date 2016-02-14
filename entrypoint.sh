#!/bin/sh

set -e

# Replace env variables in config file
[ $SERPOSCOPE_DB_URL ] && sed -i "s;^#serposcope.db.url=;serposcope.db.url=${SERPOSCOPE_DB_URL};g" /etc/serposcope.conf
[ $SERPOSCOPE_DB_OPTIONS ] && sed -i "s;^#serposcope.db.options=;serposcope.db.options=${SERPOSCOPE_DB_OPTIONS};g" /etc/serposcope.conf
[ $SERPOSCOPE_DB_DEBUG ] && sed -i "s;^#serposcope.db.debug=;serposcope.db.debug=${SERPOSCOPE_DB_DEBUG};g" /etc/serposcope.conf

java -Dserposcope.conf=/etc/serposcope.conf -jar /opt/serposcope.jar
