

## Steps To Add Org2

1. Generate crypto material for Org2
   
2. ​configtxgen​ to print out the ​Org2​ organization definition in JSON format
   configtxgen -printOrg Org2MSP > ./config/org2_definition.json

3. Update channel configuration 
4. Join channel

....
updateConfig script not working 