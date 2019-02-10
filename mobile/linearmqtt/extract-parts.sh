mkdir -p parts

# Extract the template parts

SUMMARY_DASHBOARD=$(jq -r '.dashboards[0]' settings.json)
echo $SUMMARY_DASHBOARD > parts/summarydashboard.json

MONITOR_SUMMARY=$(jq -r '.dashboards[0].dashboard[0]' settings.json)
echo $MONITOR_SUMMARY > parts/metersummary.json

MONITOR_TAB=$(jq -r '.tabs[1]' settings.json)
echo $MONITOR_TAB > parts/metertab.json

MONITOR_DASHBOARD=$(jq -r '.dashboards[1]' settings.json)
echo $MONITOR_DASHBOARD > parts/meterdashboard.json

# Protector

PROTECTOR_SUMMARY=$(jq -r '.dashboards[0].dashboard[1]' settings.json)
echo $PROTECTOR_SUMMARY > parts/protectorsummary.json

PROTECTOR_TAB=$(jq -r '.tabs[2]' settings.json)
echo $PROTECTOR_TAB > parts/protectortab.json

PROTECTOR_DASHBOARD=$(jq -r '.dashboards[2]' settings.json)
echo $PROTECTOR_DASHBOARD > parts/protectordashboard.json

# Ventilator
VENTILATOR_SUMMARY=$(jq -r '.dashboards[0].dashboard[2]' settings.json)
echo $VENTILATOR_SUMMARY > parts/ventilatorsummary.json

VENTILATOR_TAB=$(jq -r '.tabs[3]' settings.json)
echo $VENTILATOR_TAB > parts/ventilatortab.json

VENTILATOR_DASHBOARD=$(jq -r '.dashboards[3]' settings.json)
echo $VENTILATOR_DASHBOARD > parts/ventilatordashboard.json

# Illuminator
ILLUMINATOR_SUMMARY=$(jq -r '.dashboards[0].dashboard[3]' settings.json)
echo $ILLUMINATOR_SUMMARY > parts/illuminatorsummary.json

ILLUMINATOR_TAB=$(jq -r '.tabs[4]' settings.json)
echo $ILLUMINATOR_TAB > parts/illuminatortab.json

ILLUMINATOR_DASHBOARD=$(jq -r '.dashboards[4]' settings.json)
echo $ILLUMINATOR_DASHBOARD > parts/illuminatordashboard.json


echo "Extraction complete"
