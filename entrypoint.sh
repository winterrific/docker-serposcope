#!/bin/sh

set -e

# Replace env variables in config file
for variable in $(env | grep ^SERPOSCOPE | awk -F= '{print $1}' | grep -v SERPOSCOPE_VERSION)
do
  name=$(echo $variable | tr A-Z a-z | tr _ . )
  echo "${name}=$( echo $variable)" >> /etc/serposcope.conf
done

java -Dserposcope.conf=/etc/serposcope.conf -jar /opt/serposcope.jar
