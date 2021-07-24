#  docker-compose -f docker-compose.yml up -d couchdbOrg2Peer0 peer0.org2.example.com couchdbOrg2Peer1 peer1.org2.example.com ca.org2.example.com
CHANNEL_NAME=${1-mychannel}
ORDERER_TLS_CA=`docker exec cli-peer0.org2  env | grep ORDERER_TLS_CA | cut -d'=' -f2`
docker exec cli-peer0.org2 peer channel fetch 0 $CHANNEL_NAME.pb -o orderer.example.com:7050 --tls --cafile $ORDERER_TLS_CA -c $CHANNEL_NAME

docker exec cli-peer0.org2 peer channel join -b /etc/hyperledger/channels/$CHANNEL_NAME.block
docker exec cli-peer0.org2 peer channel list

