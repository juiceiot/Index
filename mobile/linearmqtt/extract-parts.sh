mkdir -p parts

# Extract the template parts

SUMMARY_DASHBOARD=$(jq -r '.dashboards[0]' settings.json)
echo $SUMMARY_DASHBOARD > parts/summarydashboard.json

METER_SUMMARY=$(jq -r '.dashboards[0].dashboard[0]' settings.json)
echo $METER_SUMMARY > parts/metersummary.json

METER_TAB=$(jq -r '.tabs[1]' settings.json)
echo $METER_TAB > parts/metertab.json

METER_DASHBOARD=$(jq -r '.dashboards[1]' settings.json)
echo $METER_DASHBOARD > parts/meterdashboard.json

# Protector

PROTECTOR_SUMMARY=$(jq -r '.dashboards[0].dashboard[1]' settings.json)
echo $PROTECTOR_SUMMARY > parts/protectorsummary.json

PROTECTOR_TAB=$(jq -r '.tabs[2]' settings.json)
echo $PROTECTOR_TAB > parts/protectortab.json

PROTECTOR_DASHBOARD=$(jq -r '.dashboards[2]' settings.json)
echo $PROTECTOR_DASHBOARD > parts/protectordashboard.json


echo "Extraction complete"
