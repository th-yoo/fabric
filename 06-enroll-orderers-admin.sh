#!/usr/bin/env bash

# ------------------------------------------------------------------------------------------------------------------------
# Setup Orderer CA
# ------------------------------------------------------------------------------------------------------------------------


export FABRIC_CA_CLIENT_TLS_CERTFILES=$FABRIC_CFG_PATH/crypto-config/ordererOrganizations/fabric.com/ca/ca.fabric.com-cert.pem
export FABRIC_CA_CLIENT_HOME=$FABRIC_CFG_PATH/fabca/fabric.com/ca-admin
export FABRIC_CA_CLIENT_MSPDIR=$FABRIC_CFG_PATH/crypto-config/ordererOrganizations/fabric.com/orderers/orderer1.fabric.com/msp
fabric-ca-client enroll -d -u https://orderer1.fabric.com:ordererpw@0.0.0.0:7152

# Enroll Orderer's Admin
export FABRIC_CA_CLIENT_MSPDIR=$FABRIC_CFG_PATH/crypto-config/ordererOrganizations/fabric.com/users/Admin@fabric.com/msp
fabric-ca-client enroll -d -u https://Admin@fabric.com:ordereradminpw@0.0.0.0:7152

# AdminCerts
fabric-ca-client identity list
fabric-ca-client certificate list --id Admin@fabric.com --store $FABRIC_CFG_PATH/crypto-config/ordererOrganizations/fabric.com/users/Admin@fabric.com/msp/admincerts

# Copy AdminCerts to Orderer MSP AdminCerts
cp $FABRIC_CFG_PATH/crypto-config/ordererOrganizations/fabric.com/users/Admin@fabric.com/msp/admincerts/*.pem $FABRIC_CFG_PATH/crypto-config/ordererOrganizations/fabric.com/orderers/orderer1.fabric.com/msp/admincerts


# renane keystore _sk = key.pem

# --------------------------------------------------------------------------------
# Orderer TLS certificate.

export FABRIC_CA_CLIENT_TLS_CERTFILES=$FABRIC_CFG_PATH/crypto-config/ordererOrganizations/fabric.com/tlsca/tlsca.fabric.com-cert.pem
export FABRIC_CA_CLIENT_HOME=$FABRIC_CFG_PATH/fabca/fabric.com/tlsca-admin
export FABRIC_CA_CLIENT_MSPDIR=$FABRIC_CFG_PATH/crypto-config/ordererOrganizations/fabric.com/orderers/orderer1.fabric.com/tls
fabric-ca-client enroll -d -u https://orderer1.fabric.com:ordererPW@0.0.0.0:7150 --enrollment.profile tls --csr.hosts orderer1.fabric.com


export FABRIC_CA_CLIENT_MSPDIR=$FABRIC_CFG_PATH/crypto-config/ordererOrganizations/fabric.com/users/Admin@fabric.com/tls
fabric-ca-client enroll -d -u https://Admin@fabric.com:ordereradminpw@0.0.0.0:7150 --enrollment.profile tls --csr.hosts orderer1.fabric.com

