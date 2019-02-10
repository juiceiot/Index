PROTECTOR_LABEL="MyProtector"
PROTECTOR_DEVICE_NAME="myprotector"
PROTECTOR_PORT="ttyUSB1"

echo "----------" && \
echo "Testing protector ESP8266 scripts" && \
echo "----------" && \

sh clean.sh

echo "" && \
echo "Creating garden protector ESP8266" && \
echo "" && \

sh create-protector-esp.sh $PROTECTOR_LABEL $PROTECTOR_DEVICE_NAME $PROTECTOR_PORT && \

echo "" && \
echo "----------" && \
echo "Checking results" && \
echo "----------" && \

# Skip MQTT bridge and updater service verification because they aren't used with the WiFi version

#sh verify-device-ui.sh 1 "protector" $PROTECTOR_DEVICE_NAME $PROTECTOR_LABEL $PROTECTOR_PORT && \

#echo "" && \
#echo "----------" && \
#echo "Cleaning up" && \
#echo "----------" && \

#sh remove-device.sh $PROTECTOR_DEVICE_NAME && \

echo "Protector ESP8266 test complete"
