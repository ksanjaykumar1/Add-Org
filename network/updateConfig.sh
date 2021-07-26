
# Script not working , execute the commands individually inside the cli-peer0.org1 container without 'docker exec  cli-peer0.org1'
# error because,  json files on line 18 ,27 38 are being create locally on this folder instead of container 

exporCHANNEL_NAME=${1-mychannel}


echo "org2 joining channel '$CHANNEL_NAME'"

configtxgen -printOrg Org2MSP > ./orderer/org2_definition.json

ORDERER_TLS_CA=`docker exec cli-peer0.org1  env | grep ORDERER_TLS_CA | cut -d'=' -f2`

docker exec -it cli-peer0.org1 bash -c 'export CHANNEL_NAME=\"$CHANNEL_NAME\"'

docker exec -it cli-peer0.org1 bash -c 'echo $CHANNEL_NAME'

# echo "Feteching gensis block of channel '$CHANNEL_NAME'"
# docker exec  cli-peer0.org1 peer channel fetch config blockFetchedConfig.pb -c $CHANNEL_NAME -o orderer.example.com:7050 --tls --cafile $ORDERER_TLS_CA 

# echo " decoding the original block into json file"

# docker exec  cli-peer0.org1 configtxlator proto_decode --input blockFetchedConfig.pb --type common.Block | jq .data.data[0].payload.data.config > configBlock.json


# # configtxlator proto_decode --input blockFetchedConfig.pb --type common.Block | jq .data.data[0].payload.data.config > configBlock.json

# # docker exec cli-peer0.org1 cat configBlock.json > originalblock.txt

# echo " adding Org2 defination"

# docker exec  cli-peer0.org1 jq -s '.[0] * {"channel_group":{"groups":{"Application":{"groups":{"Org2MSP":.[1]}}}}}' configBlock.json /etc/hyperledger/orderer/org2_definition.json > configChanges.json

# # docker exec  cli-peer0.org1 cat configChanges.json | grep Org2


# docker exec  cli-peer0.org1 configtxlator proto_encode --input configBlock.json --type common.Config --output configBlock.pb

# docker exec  cli-peer0.org1 configtxlator proto_encode --input configChanges.json --type common.Config --output configChanges.pb 

# docker exec  cli-peer0.org1 configtxlator compute_update --channel_id $CHANNEL_NAME --original configBlock.pb --updated configChanges.pb --output configProposal_Org2.pb

# docker exec  cli-peer0.org1 configtxlator proto_decode --input configProposal_Org2.pb --type common.ConfigUpdate | jq . > configProposal_Org2.json

# docker exec  cli-peer0.org1 echo '{"payload":{"header":{"channel_header":{"channel_id":"'"$CHANNEL_NAME"'","type":2}},"data":{"config_update":'$(cat configProposal_Org2.json)'}}}' | jq . > org2SubmitReady.json



# docker exec  cli-peer0.org1 configtxlator proto_encode --input org2SubmitReady.json --type common.Envelope --output org2SubmitReady.pb

# docker exec  cli-peer0.org1 peer channel signconfigtx -f org2SubmitReady.pb

# # docker exec cli-peer0.org1 cat org2SubmitReady.json > .txt

# docker exec  cli-peer0.org1 peer channel update -f org2SubmitReady.pb -c $CHANNEL_NAME -o orderer.example.com:7050 --tls --cafile $ORDERER_TLS_CA

