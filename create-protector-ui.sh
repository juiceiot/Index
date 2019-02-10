echo ""
echo "Creating garden protector configuration"
echo ""

# Example:
# sh create-protector-ui.sh [Label] [DeviceName]
# sh create-protector-ui.sh MyProtector myprotector

DIR=$PWD
DEVICE_EXISTS=false

DEVICE_LABEL=$1
DEVICE_NAME=$2

if [ ! $DEVICE_LABEL ]; then
  DEVICE_LABEL="Protector1"
fi
if [ ! $DEVICE_NAME ]; then
  DEVICE_NAME="protector1"
fi

DEVICE_INFO_DIR="devices/$DEVICE_NAME"
if [ -d "$DEVICE_INFO_DIR" ]; then
  DEVICE_EXISTS=true
fi


if [ $DEVICE_EXISTS = false ]; then
  cd "mobile/linearmqtt/"

  sh increment-device-count.sh

  echo "Device label: $DEVICE_LABEL"
  echo "Device name: $DEVICE_NAME"

  DEVICE_COUNT=$(cat devicecount.txt) && \
  DEVICE_ID=$(($DEVICE_COUNT+1)) && \

  echo "Device number: $DEVICE_COUNT" && \

  # Protector tab

  PROTECTOR_TAB=$(cat parts/protectortab.json)

  PROTECTOR_TAB=$(echo $PROTECTOR_TAB | sed "s/Protector1/$DEVICE_LABEL/g") && \
  PROTECTOR_TAB=$(echo $PROTECTOR_TAB | sed "s/protector1/$DEVICE_NAME/g") && \

  PROTECTOR_TAB=$(echo $PROTECTOR_TAB | jq .id=$DEVICE_ID) && \

  NEW_SETTINGS=$(jq ".tabs[$DEVICE_COUNT] |= . + $PROTECTOR_TAB" newsettings.json) && \

  echo $NEW_SETTINGS > newsettings.json && \

  # Protector summary

  PROTECTOR_SUMMARY=$(cat parts/protectorsummary.json) && \

  PROTECTOR_SUMMARY=$(echo $PROTECTOR_SUMMARY | sed "s/Protector1/$DEVICE_LABEL/g") && \
  PROTECTOR_SUMMARY=$(echo $PROTECTOR_SUMMARY | sed "s/protector1/$DEVICE_NAME/g") && \

  #PROTECTOR_SUMMARY=$(echo $PROTECTOR_SUMMARY | jq .id=$DEVICE_ID) && \

  NEW_SETTINGS=$(jq ".dashboards[0].dashboard[$(($DEVICE_COUNT-1))] |= . + $PROTECTOR_SUMMARY" newsettings.json) && \

  echo $NEW_SETTINGS > newsettings.json && \


  # Protector dashboard

  PROTECTOR_DASHBOARD=$(cat parts/protectordashboard.json) && \

  PROTECTOR_DASHBOARD=$(echo $PROTECTOR_DASHBOARD | sed "s/Protector1/$DEVICE_LABEL/g") && \
  PROTECTOR_DASHBOARD=$(echo $PROTECTOR_DASHBOARD | sed "s/protector1/$DEVICE_NAME/g") && \

  #PROTECTOR_DASHBOARD=$(echo $PROTECTOR_DASHBOARD | jq .id=$DEVICE_ID) && \

  NEW_SETTINGS=$(jq ".dashboards[$DEVICE_COUNT] |= . + $PROTECTOR_DASHBOARD" newsettings.json) && \

  echo $NEW_SETTINGS > newsettings.json && \

  NEW_SETTINGS=$(jq ".dashboards[$DEVICE_COUNT].id=\"$DEVICE_ID\"" newsettings.json) && \

  echo $NEW_SETTINGS > newsettings.json && \

  sh package.sh
else
  echo "Device already exists. Skipping UI creation."
fi


cd $DIR && \

echo "Finished creating protector UI"
