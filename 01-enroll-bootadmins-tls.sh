#!/usr/bin/env bash

# bootadmin enroll and identity register generate nothing but update sqlite db

# ------------------------------------------------------------------------------------------------------
# Register orderer identities with the tls-ca-orderer
# ------------------------------------------------------------------------------------------------------
export FABRIC_CA_CLIENT_TLS_CERTFILES=$FABRIC_CFG_PATH/crypto-config/ordererOrganizations/fabric.com/tlsca/tlsca.fabric.com-cert.pem
export FABRIC_CA_CLIENT_HOME=$FABRIC_CFG_PATH/fabca/fabric.com/tlsca-admin

fabric-ca-client enroll -d -u https://tls-ord-admin:tls-ord-adminpw@0.0.0.0:7150
fabric-ca-client register -d --id.name orderer1.fabric.com --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7150
fabric-ca-client register -d --id.name Admin@fabric.com --id.secret ordereradminpw --id.type admin -u https://0.0.0.0:7150

# ------------------------------------------------------------------------------------------------------
# Register peer identities with the tls-ca-peer
# ------------------------------------------------------------------------------------------------------

export FABRIC_CA_CLIENT_TLS_CERTFILES=$FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/tlsca/tlsca.po1.fabric.com-cert.pem
export FABRIC_CA_CLIENT_HOME=$FABRIC_CFG_PATH/fabca/po1.fabric.com/tlsca-admin

fabric-ca-client enroll -d -u https://tls-peer-admin:tls-peer-adminpw@0.0.0.0:7151
fabric-ca-client register -d --id.name peer0.po1.fabric.com --id.secret peer0PW --id.type peer -u https://0.0.0.0:7151
fabric-ca-client register -d --id.name peer1.po1.fabric.com --id.secret peer0PW --id.type peer -u https://0.0.0.0:7151
fabric-ca-client register -d --id.name Admin@po1.fabric.com --id.secret po1AdminPW --id.type admin -u https://0.0.0.0:7151

