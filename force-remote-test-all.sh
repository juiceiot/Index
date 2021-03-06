#!/bin/bash

BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

if [ "$BRANCH" = "dev" ]
then
  DIR=$PWD

  sh force-remote-test.sh || exit 1
  echo ""
  
  echo "Monitor"
  cd sketches/meter/SoilMoistureSensorCalibratedSerial/
  sh force-remote-test.sh || exit 1
  cd $DIR
  echo ""
  
  echo "Monitor ESP"
  cd sketches/meter/SoilMoistureSensorCalibratedSerialESP/
  sh force-remote-test.sh || exit 1
  cd $DIR
  echo ""
  
  echo "Protector"
  cd sketches/protector/SoilMoistureSensorCalibratedPump/
  sh force-remote-test.sh || exit 1
  cd $DIR
  echo ""
  
  echo "Protector ESP"
  cd sketches/protector/SoilMoistureSensorCalibratedPump/
  sh force-remote-test.sh || exit 1
  cd $DIR
  echo ""
  
  echo "Ventilator"
  cd sketches/ventilator/TemperatureHumidityDHTSensorFan/
  sh force-remote-test.sh || exit 1
  cd $DIR
  echo ""
  
  echo "Illuminator"
  cd sketches/illuminator/LightPRSensorCalibratedLight/
  sh force-remote-test.sh || exit 1
  cd $DIR
  echo ""

  echo "Tests for all projects should now have started on the test server."
else
  echo "Cannot force retest from master branch. Switch to dev branch first."
fi
