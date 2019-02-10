echo "Initializing JuiceIoT index submodules"

DIR=$PWD

git submodule update --init --recursive || "Submodule update failed"

echo "" && \
echo "Initializing JuiceIoT meter (SoilMoistureSensorCalibratedSerial) submodule" && \

cd sketches/meter/SoilMoistureSensorCalibratedSerial/ && \
sh init.sh && \
cd $DIR && \

echo "" && \
echo "Initializing JuiceIoT WiFi/ESP meter (SoilMoistureSensorCalibratedSerialESP) submodule" && \

cd sketches/meter/SoilMoistureSensorCalibratedSerialESP/ && \
sh init.sh && \
cd $DIR && \

echo "" && \
echo "Initializing JuiceIoT protector (SoilMoistureSensorCalibratedPump) submodule" && \

cd sketches/protector/SoilMoistureSensorCalibratedPump/ && \
sh init.sh && \
cd $DIR && \

echo "" && \
echo "Initializing JuiceIoT WiFi/ESP protector (SoilMoistureSensorCalibratedPumpESP) submodule" && \

cd sketches/protector/SoilMoistureSensorCalibratedPumpESP/ && \
sh init.sh && \
cd $DIR && \

echo "" && \
echo "Initializing JuiceIoT ventilator (TemperatureHumidityDHTSensorFan) submodule" && \

cd sketches/ventilator/TemperatureHumidityDHTSensorFan/ && \
sh init.sh && \
cd $DIR && \
echo "" && \

echo "Initializing JuiceIoT illuminator (LightPRSensorCalibratedLight) submodule" && \

cd sketches/illuminator/LightPRSensorCalibratedLight/ && \
sh init.sh && \
cd $DIR && \

echo "Finished initializing submodules"
