echo ""
echo "Setting up JuiceIoT index from GitHub"
echo ""

BRANCH=$1

if [ "$BRANCH" = "" ]; then
  if [ -d ".git" ]; then
    BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  else
    BRANCH="master"
  fi
fi

echo "Branch: $BRANCH"

if ! type "git" > /dev/null; then
  sudo apt-get update && sudo apt-get install -y git
fi

git clone --recursive https://github.com/JuiceIoT/Index.git JuiceIoT/Index -b $BRANCH && \

echo "Current directory:"
echo "  $PWD"

INDEX_DIR="JuiceIoT/Index" && \

echo "JuiceIoT index directory:" && \
echo "  $INDEX_DIR" && \

cd $INDEX_DIR && \

sudo sh prepare.sh && \
sh init.sh && \

echo "" && \
echo "The JuiceIoT index is initialized and ready to use."



