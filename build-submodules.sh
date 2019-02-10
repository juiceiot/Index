INDEX_DIR=$PWD

echo "Building meter" && \
cd sketches/meter/VoltageCurrentMAX471SensorCalibratedSerial && \
sh build-all.sh && \
cd $INDEX_DIR && \
echo "" && \

echo "Building protector" && \
cd sketches/protector/VoltageCurrentMAX471SensorCalibratedSwitch && \
sh build-all.sh && \
cd $INDEX_DIR && \
echo "" && \

echo "Submodules were built successfully."
