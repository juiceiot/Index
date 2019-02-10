echo "Initializing nunit tests"

DIR=$PWD

cd lib && \
sh get-libs.sh && \
cd $DIR
