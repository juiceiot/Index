
echo "----------"
echo "Testing create system scripts"
echo "----------"

sh create-system.sh && \

echo "----------" && \
echo "Checking results" && \
echo "----------" && \

SERVICE_FILE="/lib/systemd/system/juiceiot-mosquitto-docker.service" && \

if [ ! -f "$SERVICE_FILE" ]; then
    echo "Mosquitto docker service file not found at:" && \
    echo "$SERVICE_FILE" && \
    exit 1
else
    echo "Mosquitto docker service file found:" && \
    echo "$SERVICE_FILE"
fi

echo "----------" && \
echo "Cleaning up" && \
echo "----------" && \

sh disable-system.sh