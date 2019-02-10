echo ""
echo "Creating system meter configuration"
echo ""


# Example:
# sh create-meter-ui.sh [Label] [DeviceName]
# sh create-meter-ui.sh MyMonitor mymeter

PROJECT_DIR=$PWD
DEVICE_EXISTS=false

DEVICE_LABEL=$1
DEVICE_NAME=$2

if [ ! $DEVICE_LABEL ]; then
  DEVICE_LABEL="Monitor1"
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

  # Monitor tab

  MONITOR_TAB=$(cat parts/metertab.json) && \

#  echo "---------- Monitor Tab: Before"
#  echo $MONITOR_TAB
#  echo "----------"

  MONITOR_TAB=$(echo $MONITOR_TAB | sed "s/Monitor1/$DEVICE_LABEL/g") && \
  MONITOR_TAB=$(echo $MONITOR_TAB | sed "s/meter1/$DEVICE_NAME/g") && \

  MONITOR_TAB=$(echo $MONITOR_TAB | jq .id=$DEVICE_ID) && \

#  echo "---------- Monitor Tab: After"
#  echo $MONITOR_TAB
#  echo "----------"

  NEW_SETTINGS=$(jq ".tabs[$DEVICE_COUNT] |= . + $MONITOR_TAB" $NEW_LINEAR_MQTT_SETTINGS_FILE) && \

  echo $NEW_SETTINGS > $NEW_LINEAR_MQTT_SETTINGS_FILE && \

  # Monitor summary

  MONITOR_SUMMARY=$(cat parts/metersummary.json) && \

#  echo "---------- Monitor Summary: Before"
#  echo $MONITOR_SUMMARY
#  echo "----------"

  MONITOR_SUMMARY=$(echo $MONITOR_SUMMARY | sed "s/Monitor1/$DEVICE_LABEL/g") && \
  MONITOR_SUMMARY=$(echo $MONITOR_SUMMARY | sed "s/meter1/$DEVICE_NAME/g") && \

  #echo "---------- Monitor Summary: After"
  #echo $MONITOR_SUMMARY
  #echo "----------"

  DEVICE_INDEX=$(($DEVICE_COUNT-1))

  echo "Device index: $DEVICE_INDEX"

  NEW_SETTINGS=$(jq ".dashboards[0].dashboard[$(($DEVICE_INDEX))] |= . + $MONITOR_SUMMARY" $NEW_LINEAR_MQTT_SETTINGS_FILE) && \

  echo $NEW_SETTINGS > $NEW_LINEAR_MQTT_SETTINGS_FILE && \

  # Monitor dashboard

  MONITOR_DASHBOARD=$(cat parts/meterdashboard.json) && \

  #echo "---------- Monitor Dashboard: Before"
  #echo $MONITOR_DASHBOARD
  #echo "----------"

  MONITOR_DASHBOARD=$(echo $MONITOR_DASHBOARD | sed "s/Monitor1/$DEVICE_LABEL/g") && \
  MONITOR_DASHBOARD=$(echo $MONITOR_DASHBOARD | sed "s/meter1/$DEVICE_NAME/g") && \

  #MONITOR_DASHBOARD=$(echo $MONITOR_DASHBOARD | jq .id="$DEVICE_ID") && \

  #echo "---------- Monitor Dashboard: After"
  #echo $MONITOR_DASHBOARD
  #echo "----------"

  NEW_SETTINGS=$(jq ".dashboards[$DEVICE_COUNT] |= . + $MONITOR_DASHBOARD" $NEW_LINEAR_MQTT_SETTINGS_FILE) && \

  echo $NEW_SETTINGS > newsettings.json && \

  NEW_SETTINGS=$(jq ".dashboards[$DEVICE_COUNT].id=\"$DEVICE_ID\"" $NEW_LINEAR_MQTT_SETTINGS_FILE) && \

  echo $NEW_SETTINGS > $NEW_LINEAR_MQTT_SETTINGS_FILE && \

  sh package.sh
else
  echo "Device already exists. Skipping UI creation."
fi

cd $DIR

echo "Completed creation of system meter UI"
