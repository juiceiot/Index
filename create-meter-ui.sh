echo ""
echo "Creating system meter configuration"
echo ""


# Example:
# sh create-meter-ui.sh [Label] [DeviceName]
# sh create-meter-ui.sh MyMeter mymeter

PROJECT_DIR=$PWD
DEVICE_EXISTS=false

DEVICE_LABEL=$1
DEVICE_NAME=$2

if [ ! $DEVICE_LABEL ]; then
  DEVICE_LABEL="Meter1"
fi
if [ ! $DEVICE_NAME ]; then
  DEVICE_NAME="meter1"
fi

DEVICE_INFO_DIR="devices/$DEVICE_NAME"
if [ -d "$DEVICE_INFO_DIR" ]; then
  DEVICE_EXISTS=true
fi

cd "mobile/linearmqtt/"

NEW_LINEAR_MQTT_SETTINGS_FILE="newsettings.json"

if [ $DEVICE_EXISTS = false ]; then
  sh increment-device-count.sh

  echo "Device label: $DEVICE_LABEL"
  echo "Device name: $DEVICE_NAME"

  DEVICE_COUNT=$(cat devicecount.txt) && \
  DEVICE_ID=$(($DEVICE_COUNT+1)) && \

  echo "Device number: $DEVICE_COUNT" && \

  echo ""
  echo "Setting up json"

  # Meter tab

  METER_TAB=$(cat parts/metertab.json) && \

#  echo "---------- Meter Tab: Before"
#  echo $METER_TAB
#  echo "----------"

  METER_TAB=$(echo $METER_TAB | sed "s/Meter1/$DEVICE_LABEL/g") && \
  METER_TAB=$(echo $METER_TAB | sed "s/meter1/$DEVICE_NAME/g") && \

  METER_TAB=$(echo $METER_TAB | jq .id=$DEVICE_ID) && \

#  echo "---------- Meter Tab: After"
#  echo $METER_TAB
#  echo "----------"

  NEW_SETTINGS=$(jq ".tabs[$DEVICE_COUNT] |= . + $METER_TAB" $NEW_LINEAR_MQTT_SETTINGS_FILE) && \

  echo $NEW_SETTINGS > $NEW_LINEAR_MQTT_SETTINGS_FILE && \

  # Meter summary

  METER_SUMMARY=$(cat parts/metersummary.json) && \

#  echo "---------- Meter Summary: Before"
#  echo $METER_SUMMARY
#  echo "----------"

  METER_SUMMARY=$(echo $METER_SUMMARY | sed "s/Meter1/$DEVICE_LABEL/g") && \
  METER_SUMMARY=$(echo $METER_SUMMARY | sed "s/meter1/$DEVICE_NAME/g") && \

  #echo "---------- Meter Summary: After"
  #echo $METER_SUMMARY
  #echo "----------"

  DEVICE_INDEX=$(($DEVICE_COUNT-1))

  echo "Device index: $DEVICE_INDEX"

  NEW_SETTINGS=$(jq ".dashboards[0].dashboard[$(($DEVICE_INDEX))] |= . + $METER_SUMMARY" $NEW_LINEAR_MQTT_SETTINGS_FILE) && \

  echo $NEW_SETTINGS > $NEW_LINEAR_MQTT_SETTINGS_FILE && \

  # Meter dashboard

  METER_DASHBOARD=$(cat parts/meterdashboard.json) && \

  #echo "---------- Meter Dashboard: Before"
  #echo $METER_DASHBOARD
  #echo "----------"

  METER_DASHBOARD=$(echo $METER_DASHBOARD | sed "s/Meter1/$DEVICE_LABEL/g") && \
  METER_DASHBOARD=$(echo $METER_DASHBOARD | sed "s/meter1/$DEVICE_NAME/g") && \

  #METER_DASHBOARD=$(echo $METER_DASHBOARD | jq .id="$DEVICE_ID") && \

  #echo "---------- Meter Dashboard: After"
  #echo $METER_DASHBOARD
  #echo "----------"

  NEW_SETTINGS=$(jq ".dashboards[$DEVICE_COUNT] |= . + $METER_DASHBOARD" $NEW_LINEAR_MQTT_SETTINGS_FILE) && \

  echo $NEW_SETTINGS > newsettings.json && \

  NEW_SETTINGS=$(jq ".dashboards[$DEVICE_COUNT].id=\"$DEVICE_ID\"" $NEW_LINEAR_MQTT_SETTINGS_FILE) && \

  echo $NEW_SETTINGS > $NEW_LINEAR_MQTT_SETTINGS_FILE && \

  sh package.sh
else
  echo "Device already exists. Skipping UI creation."
fi

cd $DIR

echo "Completed creation of system meter UI"
