echo "Updating submodules by checking out the master branch and pulling from origin..."

BRANCH=$1

if [ ! "$BRANCH" ]; then
  BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
fi

echo "Branch: $BRANCH"

DIR=$PWD

git submodule update --init

echo "Updating SoilMoistureSensorCalibratedSerial"

cd sketches/meter/SoilMoistureSensorCalibratedSerial && \
sh clean.sh && \
git checkout $BRANCH && \
git pull origin $BRANCH || exit 1

cd $DIR

echo "Updating SoilMoistureSensorCalibratedSerialESP"

cd sketches/meter/SoilMoistureSensorCalibratedSerialESP && \
sh clean.sh && \
git checkout $BRANCH && \
git pull origin $BRANCH || exit 1

cd $DIR

echo "Updating SoilMoistureSensorCalibratedPump"

cd sketches/protector/SoilMoistureSensorCalibratedPump && \
sh clean.sh && \
git checkout $BRANCH && \
git pull origin $BRANCH || exit 1

cd $DIR

echo "Updating SoilMoistureSensorCalibratedPumpESP"

cd sketches/protector/SoilMoistureSensorCalibratedPumpESP && \
sh clean.sh && \
git checkout $BRANCH && \
git pull origin $BRANCH || exit 1

cd $DIR

#git commit -am "Updated submodules"

echo "Finished updating submodules"
