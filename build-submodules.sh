INDEX_DIR=$PWD

echo "Building meter" && \
cd sketches/meter/SoilMoistureSensorCalibratedSerial && \
sh build-all.sh && \
cd $INDEX_DIR && \
echo "" && \

echo "Building meter ESP" && \
cd sketches/meter/SoilMoistureSensorCalibratedSerialESP && \
sh build-all.sh && \
cd $INDEX_DIR && \
echo "" && \

echo "Building protector" && \
cd sketches/protector/SoilMoistureSensorCalibratedPump && \
sh build-all.sh && \
cd $INDEX_DIR && \
echo "" && \

echo "Building protector ESP" && \
cd sketches/protector/SoilMoistureSensorCalibratedPumpESP && \
sh build-all.sh && \
cd $INDEX_DIR && \
echo "" && \

echo "Submodules were built successfully."
