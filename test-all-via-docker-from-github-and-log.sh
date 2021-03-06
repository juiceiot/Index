#!/bin/bash

echo ""
echo "Starting test of entire JuiceIoT project suite"
echo ""

BRANCH="dev"

PROJECT_TEST_SCRIPT_URL="https://raw.githubusercontent.com/JuiceIoT/Index/$BRANCH/test-project-via-docker-from-github-and-log.sh"

curl -H 'Cache-Control: no-cache' -s $PROJECT_TEST_SCRIPT_URL | bash -s 1 "sketches/meter/SoilMoistureSensorCalibratedSerial" $BRANCH
curl -H 'Cache-Control: no-cache' -s $PROJECT_TEST_SCRIPT_URL | bash -s 2 "sketches/protector/SoilMoistureSensorCalibratedPump" $BRANCH

BRANCH="master"

PROJECT_TEST_SCRIPT_URL="https://raw.githubusercontent.com/JuiceIoT/Index/$BRANCH/test-project-via-docker-from-github-and-log.sh"

curl -H 'Cache-Control: no-cache' -s $PROJECT_TEST_SCRIPT_URL | bash -s 1 "sketches/meter/SoilMoistureSensorCalibratedSerial" $BRANCH
curl -H 'Cache-Control: no-cache' -s $PROJECT_TEST_SCRIPT_URL | bash -s 2 "sketches/protector/SoilMoistureSensorCalibratedPump" $BRANCH


echo ""
echo "Finished tests!"
echo ""
