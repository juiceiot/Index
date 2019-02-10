BRANCH=$1

if [ ! $BRANCH ]; then
  BRANCH="master"
fi

DIR=$PWD

echo "Switching index to $BRANCH branch"

git checkout $BRANCH && \
git pull origin $BRANCH

cd $DIR

echo "Switching meter to $BRANCH branch"

cd sketches/meter/SoilMoistureSensorCalibratedSerial/
sh clean.sh && \
git checkout $BRANCH && \
git pull origin $BRANCH

cd $DIR

echo "Switching ESP meter to $BRANCH branch"

cd sketches/meter/SoilMoistureSensorCalibratedSerialESP/
sh clean.sh && \
git checkout $BRANCH && \
git pull origin $BRANCH

cd $DIR

echo "Switching protector to $BRANCH branch"

cd sketches/protector/SoilMoistureSensorCalibratedPump/
sh clean.sh && \
git checkout $BRANCH && \
git pull origin $BRANCH

cd $DIR

echo "Switching ESP protector to $BRANCH branch"

cd sketches/protector/SoilMoistureSensorCalibratedPumpESP/

git pull origin $BRANCH && \
git checkout $BRANCH

cd $DIR

echo "Finished switching to $BRANCH"
