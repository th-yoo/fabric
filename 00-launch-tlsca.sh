# launch docker-compose-tls.yaml
 
# Copy the TLS CA Cert and Private Key 
# we have two keys
# $ openssl ec -in ....._sk -text -noout
# openssl command line usage
# https://gist.github.com/rustymagnet3000/e1bad38d30827e2f9f68bedc7534084d
# https://stackoverflow.com/questions/54469754/unable-to-feed-certificate-and-key-into-openssl-via-stdin
# openssl doesn't work with stdin
# workaround -in /dev/stdin
#
# extract the public key from the certificate
# $ openssl x509 -pubkey -noout -in tlsca.fabric.com-cert.pem 
#   | openssl ec -pubin -in /dev/stdin -text -noout
#
# extract the public key from the private key
# $ openssl ec -in ....._sk -pubout
cp fabric.com/tlsca-server/msp/keystore/23db0a**&&*&*&*bc527_sk  $FABRIC_CFG_PATH/crypto-config/ordererOrganizations/fabric.com/tlsca

cp po1.fabric.com/tlsca-server/msp/keystore/23db0a**&&*&*&*bc527_sk  $FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/tlsca

