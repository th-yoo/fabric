# ------------------------------------------------------------------------------------------------------
# Launch Peers
# ------------------------------------------------------------------------------------------------------

#peer1-org1.yaml
cd $FABRIC_CFG_PATH/scripts
docker-compose -f peer0-po1.yaml up
docker-compose -f peer0-po1.yaml down

docker-compose -f docker-compose-cli.yaml up peer0.po1.fabric.com

