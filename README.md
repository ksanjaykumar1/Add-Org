

This is a Hyperledger Fabric Network with 1 Org

Will update readme soon. 
### Steps
(execute these comands in network folder)
1. FABRIC_CFG_PATH should point to where configtx.yaml file exist
    export FABRIC_CFG_PATH=${PWD}
2. Remove previous crypto material and config transactions
    mkdir -p config
    rm -fr config/*
    rm -fr crypto-config/*
    Or else you will get error and orderer node will exit due to configuration 
3. Create Cryto material for Org1 and ordere , using cryto-config.yaml file
   cryptogen generate --config=./crypto-config.yaml

4. Generate network configuration files , genesis block for orderer 
    configtxgen -profile OneOrgOrdererGenesis -channelID system-channel -outputBlock ./config/genesis.block
    
    without this the ordere will fail to start
5. bring up the network by 
   docker-compose up
   (docker-compose up -d) if you don't want to see the docker logs
6. a
7. docker exec -it cli-peer0.org1 bash -c 'peer channel create -o orderer.example.com:7050 -c channel2 -f /etc/hyperledger/configtx/channel2.tx --tls --cafile $ORDERER_TLS_CA'
8. docker exec -it cli-peer1.org1 bash -c 'peer channel fetch oldest mychannel.block -c mychannel --orderer orderer.example.com:7050 --tls --cafile $ORDERER_TLS_CA'
9.  docker exec -it cli-peer1.org1 bash -c 'peer channel join -b mychannel.block'