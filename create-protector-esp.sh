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
echo "Setting up Linear MQTT Dashboard UI..."
sh create-protector-ui.sh $DEVICE_LABEL $DEVICE_NAME $DEVICE_PORT && \

# Create device info
sh create-device-info.sh protector/SoilMoistureSensorCalibratedPumpESP $DEVICE_LABEL $DEVICE_NAME $DEVICE_PORT && \

# Skip the MQTT bridge service because it's not needed for the ESP version and the updater service because it won't work when not plugged in via USB

# Uploading sketch
sh upload-protector-esp-sketch.sh $DEVICE_NAME $DEVICE_PORT && \

echo "Garden protector created with device name '$DEVICE_NAME'"
