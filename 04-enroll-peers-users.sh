#!/usr/bin/env bash

# PEER ORG


# tlsca enroll peer0.po1.fabric.com, peer1.po1.fabric.com

# ------------------------------------------------------------------------------------------------------
# Enroll peers with the CA 
# Before starting up a peer, enroll the peer identities with the CA to get the MSP that the peer will use.
# This is known as the local peer MSP.
# ------------------------------------------------------------------------------------------------------

export FABRIC_CA_CLIENT_TLS_CERTFILES=$FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/ca/ca.po1.fabric.com-cert.pem
export FABRIC_CA_CLIENT_HOME=$FABRIC_CFG_PATH/fabca/po1.fabric.com/ca-admin
export FABRIC_CA_CLIENT_MSPDIR=$FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/peers/peer0.po1.fabric.com/msp
fabric-ca-client enroll -d -u https://peer0.po1.fabric.com:peer1PW@0.0.0.0:7153 --csr.hosts peer0.po1.fabric.com

export FABRIC_CA_CLIENT_MSPDIR=$FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/peers/peer1.po1.fabric.com/msp 
fabric-ca-client enroll -d -u https://peer1.po1.fabric.com:peer2PW@0.0.0.0:7153 --csr.hosts peer1.po1.fabric.com


# ca enroll peer0.po1.fabric.com, peer1.po1.fabric.com

# ------------------------------------------------------------------------------------------------------
# Enroll and Get the TLS cryptographic material for the peer. 
# This requires another enrollment,
# Enroll against the ``tls`` profile on the TLS CA. 
# Copy TLS CA from TLS if on another server.

# cp $FABRIC_CFG_PATH/tls-rca/po1.fabric.com/tls/ca/server/tls-cert.pem $FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/tlsca
export FABRIC_CA_CLIENT_TLS_CERTFILES=$FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/tlsca/tlsca.po1.fabric.com-cert.pem
export FABRIC_CA_CLIENT_HOME=$FABRIC_CFG_PATH/fabca/po1.fabric.com/tlsca-admin
export FABRIC_CA_CLIENT_MSPDIR=$FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/peers/peer0.po1.fabric.com/tls

fabric-ca-client enroll -d -u https://peer0.po1.fabric.com:peer0PW@0.0.0.0:7151 --enrollment.profile tls --csr.hosts peer0.po1.fabric.com

export FABRIC_CA_CLIENT_MSPDIR=$FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/peers/peer1.po1.fabric.com/tls
fabric-ca-client enroll -d -u https://peer1.po1.fabric.com:peer0PW@0.0.0.0:7151 --enrollment.profile tls --csr.hosts peer1.po1.fabric.com








# rename keystore = key.pem

# Mutuall TLS Enabled then rename
# tls/signcerts/cert.pem = server.crt
# tls/keystore/key.pem = server.key
# tls/tlscacerts/tls-0-0-0-0-7151.pem = ca.crt

# ------------------------------------------------------------------------------------------------------
# Enroll and Setup peer org Admin User
# The admin identity is responsible for activities such as # installing and instantiating chaincode. 
# The commands below assumes that this is being executed on Peer's host machine.
# Fabric does this by Creating folder user/Admin@po1.fabric.com
# ------------------------------------------------------------------------------------------------------

export FABRIC_CA_CLIENT_TLS_CERTFILES=$FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/ca/ca.po1.fabric.com-cert.pem
export FABRIC_CA_CLIENT_HOME=$FABRIC_CFG_PATH/fabca/po1.fabric.com/ca-admin
export FABRIC_CA_CLIENT_MSPDIR=$FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/users/Admin@po1.fabric.com/msp
fabric-ca-client enroll -d -u https://Admin@po1.fabric.com:po1AdminPW@0.0.0.0:7153

# AdminCerts
fabric-ca-client identity list
fabric-ca-client certificate list --id Admin@po1.fabric.com --store $FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/users/Admin@po1.fabric.com/msp/admincerts


# --------------------------------------------------------------
# Enroll user
export FABRIC_CA_CLIENT_MSPDIR=$FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/users/User1@po1.fabric.com/msp
fabric-ca-client enroll -d -u https://User1@po1.fabric.com:po1UserPW@0.0.0.0:7153

# After enrollment, you should have an admin MSP. 
# You will copy the certificate from this MSP and move it to the Peer1's MSP in the ``admincerts``
# folder. You will need to disseminate this admin certificate to other peers in the
# org, and it will need to go in to the ``admincerts`` folder of each peers' MSP.

# --------------------------------------------------------------
# Alternate Method manual copy instead of fabric-ca-client identity list command
mkdir $FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/peers/peer0.po1.fabric.com/msp/admincerts
cp $FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/users/Admin@po1.fabric.com/msp/signcerts/cert.pem $FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/peers/peer0.po1.fabric.com/msp/admincerts

# --------------------------------------------------------------
# Enroll and Get the TLS cryptographic material for the Admin User
# Enroll against the ``tls`` profile on the TLS CA. Using Tls cert.

export FABRIC_CA_CLIENT_TLS_CERTFILES=$FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/tlsca/tlsca.po1.fabric.com-cert.pem
export FABRIC_CA_CLIENT_HOME=$FABRIC_CFG_PATH/fabca/po1.fabric.com/tlsca-admin
export FABRIC_CA_CLIENT_MSPDIR=$FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/users/Admin@po1.fabric.com/tls
fabric-ca-client enroll -d -u https://Admin@po1.fabric.com:po1AdminPW@0.0.0.0:7151 --enrollment.profile tls 

