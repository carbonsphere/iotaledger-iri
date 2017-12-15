#!/bin/bash

if [ "${REMOTE_LIMIT_API}" == '' ]; then
  APILIMIT=""
else
  APILIMIT="--remote-limit-api '${REMOTE_LIMIT_API}'"
fi

  echo "APILIMIT= ${APILIMIT}"

exec java -XX:+DisableAttachMechanism -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -Xms$MIN_MEMORY -Xmx$MAX_MEMORY -Dlogback.configurationFile=/iri/logback.xml -Djava.net.preferIPv4Stack=true -jar /iri/iri-*.jar -p ${API_PORT} -u ${UDP_PORT} -t ${TCP_PORT} -c /iri/iota.ini ${APILIMIT} --remote "$@"

