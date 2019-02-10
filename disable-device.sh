echo ""
echo "Disabling system device services"
echo ""

DIR=$PWD

DEVICE_NAME=$1

if [ ! $DEVICE_NAME ]; then
  echo "Error: Please specify a device name as an argument."
else

  echo "Device name: $DEVICE_NAME"

  echo "Disabling MQTT bridge service" && \
  sudo systemctl stop juiceiot-mqtt-bridge-$DEVICE_NAME.service && \
  sudo systemctl disable juiceiot-mqtt-bridge-$DEVICE_NAME.service && \

  echo "Disabling Updater bridge service" && \
  sudo systemctl stop juiceiot-updater-$DEVICE_NAME.service && \
  sudo systemctl disable juiceiot-updater-$DEVICE_NAME.service && \

  echo "Garden device services disabled for '$DEVICE_NAME'"

fi
