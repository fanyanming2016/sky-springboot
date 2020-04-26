#!/bin/sh

set -e

echo "Apache SkyWalking Docker Image"
sleep 1
exec java -javaagent:/skywalking/agent/skywalking-agent.jar -Dskywalking.agent.service_name=${SW_SERVICE_NAME} \
    -Dskywalking.collector.backend_service=${SW_COLLECTOR_SERVERS} -jar sk-demo.jar