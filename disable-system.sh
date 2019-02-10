echo "Disabling moquitto MQTT service"
sudo sh systemctl.sh stop juiceiot-mosquitto-docker.service && \
sudo sh systemctl.sh disable juiceiot-mosquitto-docker.service && \

echo "Stopping docker service"
sh docker.sh stop mosquitto


