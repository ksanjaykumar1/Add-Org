
echo "Generating crypto material for Org2"
cryptogen generate --config=./crypto-config2.yaml
if [ "$?" -ne 0 ]; then
  echo "Failed to generate crypto material..."
  exit 1
fi