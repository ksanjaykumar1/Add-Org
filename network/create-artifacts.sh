# Set env vars
export FABRIC_CFG_PATH=${PWD}

mkdir -p crypto-config
mkdir -p channels/*
mkdir -p orderer/*
# Remove previous crypto material
rm -fr crypto-config/*
# removing previous config transactions and files
rm -fr channels/*
rm -fr orderer/*



#echo "Generating crypto material"
cryptogen generate --config=./crypto-config.yaml
if [ "$?" -ne 0 ]; then
  echo "Failed to generate crypto material..."
  exit 1
fi

echo "Generating orderer block"
configtxgen -profile OneOrgOrdererGenesis -channelID system-channel -outputBlock ./orderer/genesis.block
if [ "$?" -ne 0 ]; then
  echo "Failed to generate orderer genesis block..."
  exit 1
fi

