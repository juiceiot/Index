echo "Initializing JuiceIoT index"

DIR=$PWD

echo "" && \
echo "Initializing JuiceIoT index unit tests" && \

cd tests/nunit/ && \
sh init.sh && \
cd $DIR && \

echo "" && \
echo "Initializing MQTT bridge utility" && \

cd scripts/apps/BridgeArduinoSerialToMqttSplitCsv/ && \
sh init.sh && \
cd $DIR && \

echo && \
echo "Initializing updater (GitDeployer) utility" && \

cd scripts/apps/GitDeployer/ && \
sh init.sh && \
cd $DIR && \

echo "" && \
echo "Initializing linear MQTT dashboard UI related scripts" && \
cd mobile/linearmqtt/ && \
sh init.sh && \
cd $DIR && \

echo "Initialization completed."
