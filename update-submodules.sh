echo "Updating submodules by checking out the master branch and pulling from origin..."

BRANCH=$1

if [ ! "$BRANCH" ]; then
  BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
fi

echo "Branch: $BRANCH"

DIR=$PWD

git submodule update --init

echo "Updating VoltageCurrentMAX471SensorCalibratedSerial"

cd sketches/meter/VoltageCurrentMAX471SensorCalibratedSerial && \
sh clean.sh && \
git checkout $BRANCH && \
git pull origin $BRANCH || exit 1

cd $DIR

echo "Updating VoltageCurrentMAX471SensorCalibratedSwitch"

cd sketches/protector/VoltageCurrentMAX471SensorCalibratedSwitch && \
sh clean.sh && \
git checkout $BRANCH && \
git pull origin $BRANCH || exit 1

cd $DIR

echo "Finished updating submodules"
