echo "Initializing JuiceIoT index submodules"

DIR=$PWD

git submodule update --init --recursive || "Submodule update failed"

echo "" && \
echo "Initializing JuiceIoT meter (VoltageCurrentMAX471SensorCalibratedSerial) submodule" && \

cd sketches/meter/VoltageCurrentMAX471SensorCalibratedSerial/ && \
sh init.sh && \
cd $DIR && \

echo "" && \
echo "Initializing JuiceIoT protector (VoltageCurrentMAX471SensorCalibratedSwitch) submodule" && \

cd sketches/protector/VoltageCurrentMAX471SensorCalibratedSwitch/ && \
sh init.sh && \
cd $DIR && \

echo "Finished initializing submodules"
