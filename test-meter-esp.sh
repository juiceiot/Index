MONITOR_LABEL="MyMonitor"
MONITOR_DEVICE_NAME="mymeter"
MONITOR_PORT="ttyUSB0"

echo "----------" && \
echo "Testing meter ESP8266 scripts" && \
echo "----------" && \

sh clean.sh

echo "" && \
echo "Creating garden meter ESP8266 services" && \
echo "" && \

sh create-meter-esp.sh $MONITOR_LABEL $MONITOR_DEVICE_NAME $MONITOR_PORT && \

echo "" && \
echo "----------" && \
echo "Checking results" && \
echo "----------" && \

# Skip MQTT bridge and updater service verification because they aren't used with the WiFi version

#sh verify-device-ui.sh 1 "meter" $MONITOR_DEVICE_NAME $MONITOR_LABEL $MONITOR_PORT && \

#echo "" && \
#echo "----------" && \
#echo "Cleaning up" && \
#echo "----------" && \

#sh remove-device.sh $MONITOR_DEVICE_NAME && \

echo "Monitor ESP8266 test complete"
