echo ""
echo "Removing system device configuration"
echo ""

DEVICE_NAME=$1

SYSTEMCTL_SCRIPT="systemctl.sh"

if [ ! $DEVICE_NAME ]; then
  echo "Error: Specify a device name as an argument."
else
  echo "Device name: $DEVICE_NAME"

  echo "Disabling MQTT bridge service" && \
  sh $SYSTEMCTL_SCRIPT disable juiceiot-mqtt-bridge-$DEVICE_NAME.service && \

  echo "Removing MQTT bridge service" && \
  rm -f scripts/apps/BridgeArduinoSerialToMqttSplitCsv/svc/juiceiot-mqtt-bridge-$DEVICE_NAME.service && \

  echo "Disabling updater service" && \
  sh $SYSTEMCTL_SCRIPT disable juiceiot-updater-$DEVICE_NAME.service && \

  echo "Removing updater service" && \
  rm -f scripts/apps/GitDeployer/svc/juiceiot-updater-$DEVICE_NAME.service && \

  # Remove from mobile UI
  #  cd mobile/linearmqtt/ && \
  #  sh remove-system-meter-ui.sh $DEVICE_NAME && \
  #  cd $DIR

  echo "Garden device removed: $DEVICE_NAME"
fi
