echo ""
echo "Creating garden protector configuration"
echo ""

# Example:
# sh create-protector.sh [Label] [DeviceName] [Port]
# sh create-protector.sh "Protector1" protector1 ttyUSB0 

DIR=$PWD

DEVICE_LABEL=$1
DEVICE_NAME=$2
DEVICE_PORT=$3

if [ ! $DEVICE_LABEL ]; then
  DEVICE_LABEL="Protector1"
fi

if [ ! $DEVICE_NAME ]; then
  DEVICE_NAME="protector1"
fi

if [ ! $DEVICE_PORT ]; then
  DEVICE_PORT="ttyUSB0"
fi

echo "Device label: $DEVICE_LABEL"
echo "Device name: $DEVICE_NAME"
echo "Device port: $DEVICE_PORT"

# Set up mobile UI
sh create-protector-ui.sh $DEVICE_LABEL $DEVICE_NAME $DEVICE_PORT && \

# Create device info
sh create-device-info.sh protector/SoilMoistureSensorCalibratedPump $DEVICE_LABEL $DEVICE_NAME $DEVICE_PORT && \

# Set up MQTT bridge service
sh create-mqtt-bridge-service.sh protector $DEVICE_NAME $DEVICE_PORT && \

# Set up update service
sh create-updater-service.sh protector uno $DEVICE_NAME $DEVICE_PORT && \

# Uploading sketch
sh upload-protector-uno-sketch.sh $DEVICE_PORT && \

echo "Garden protector created with device name '$DEVICE_NAME'"
