echo ""
echo "Restarting system device services"
echo ""

DIR=$PWD

DEVICE_NAME=$1

if [ ! $DEVICE_NAME ]; then
  echo "Error: Please specify a device name as an argument."
else

  echo "Device name: $DEVICE_NAME"

  echo "Restart MQTT bridge service" && \
  sudo systemctl restart juiceiot-mqtt-bridge-$DEVICE_NAME.service && \

  echo "Restart Updater service" && \
  sudo systemctl restart juiceiot-updater-$DEVICE_NAME.service && \

  echo "Garden device services restarted for '$DEVICE_NAME'"

fi
