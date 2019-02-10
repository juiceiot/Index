echo ""
echo "Creating power meter"
echo ""

# Example:
# sh create-meter-esp.sh [Label] [DeviceName] [Port]
# sh create-meter-esp.sh "Monitor1" meter1 ttyUSB0 

DIR=$PWD

DEVICE_LABEL=$1
DEVICE_NAME=$2
DEVICE_PORT=$3

if [ ! $DEVICE_LABEL ]; then
  DEVICE_LABEL="Monitor1"
fi

if [ ! $DEVICE_NAME ]; then
  DEVICE_NAME="meter1"
fi

if [ ! $DEVICE_PORT ]; then
  DEVICE_PORT="ttyUSB0"
fi

echo "Device label: $DEVICE_LABEL"
echo "Device name: $DEVICE_NAME"
echo "Device port: $DEVICE_PORT"

# Set up mobile UI
echo "Setting up Linear MQTT Dashboard UI..." && \
sh create-meter-ui.sh $DEVICE_LABEL $DEVICE_NAME $DEVICE_PORT && \

# Create device info
sh create-device-info.sh meter/VoltageCurrentMAX471SensorCalibratedSerial $DEVICE_LABEL $DEVICE_NAME $DEVICE_PORT && \

# Set up MQTT bridge service
sh create-mqtt-bridge-service.sh meter $DEVICE_NAME $DEVICE_PORT && \

# Set up update service
sh create-updater-service.sh meter nano $DEVICE_NAME $DEVICE_PORT && \

# Uploading sketch
sh upload-meter-nano-sketch.sh $DEVICE_PORT && \

echo "Garden meter created with device name '$DEVICE_NAME'"
