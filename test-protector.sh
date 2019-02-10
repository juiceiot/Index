PROTECTOR_LABEL="MyProtector"
PROTECTOR_DEVICE_NAME="myprotector"
PROTECTOR_PORT="ttyUSB1"

echo "----------" && \
echo "Testing protector scripts" && \
echo "----------" && \

sh clean.sh

echo "" && \
echo "Creating garden protector services" && \
echo "" && \

sh create-protector.sh $PROTECTOR_LABEL $PROTECTOR_DEVICE_NAME $PROTECTOR_PORT
