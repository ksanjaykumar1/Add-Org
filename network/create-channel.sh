
# # the first argument passed while executing this script will be assigned as channel name or if nothing is passed then default value is set as mychannel
CHANNEL_NAME=${1-mychannel}



echo "Channel name is '$CHANNEL_NAME'"

# Generate channel creation transaction
configtxgen -profile OneOrgChannel -outputCreateChannelTx ./channels/$CHANNEL_NAME.tx -channelID $CHANNEL_NAME
if [ "$?" -ne 0 ]; then
  echo "Failed to generate channel creation transaction..."
  exit 1
fi

# creating $CHANNEL_NAME.block in the working directory of cli-peer0.org1
ORDERER_TLS_CA=`docker exec cli-peer0.org1  env | grep ORDERER_TLS_CA | cut -d'=' -f2`
docker exec  cli-peer0.org1 peer channel create -o orderer.example.com:7050 -c $CHANNEL_NAME -f /etc/hyperledger/channels/$CHANNEL_NAME.tx --tls --cafile $ORDERER_TLS_CA

docker exec cli-peer0.org1 ls

# copying $CHANNEL_NAME.block in /etc/
docker exec cli-peer0.org1 cp $CHANNEL_NAME.block /etc/hyperledger/channels/

docker exec cli-peer0.org1 peer channel join -b /etc/hyperledger/channels/$CHANNEL_NAME.block

docker exec cli-peer1.org1 peer channel join -b /etc/hyperledger/channels/$CHANNEL_NAME.block

echo "channels joined by peer0.org1"
docker exec cli-peer0.org1 peer channel list
echo "channels joined by peer1.org1"
docker exec cli-peer1.org1 peer channel list

