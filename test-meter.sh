MONITOR_LABEL="MyMonitor"
MONITOR_DEVICE_NAME="mymeter"
MONITOR_PORT="ttyUSB0"

echo "----------" && \
echo "Testing meter scripts" && \
echo "----------" && \

sh clean.sh && \
sh remove-devices.sh && \

echo "" && \
echo "Creating garden meter services" && \
echo "" && \

sh create-meter.sh $MONITOR_LABEL $MONITOR_DEVICE_NAME $MONITOR_PORT
