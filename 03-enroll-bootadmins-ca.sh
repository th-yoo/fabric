#!/usr/bin/env bash

# enroll orderer org fabric.com in ca
export FABRIC_CA_CLIENT_TLS_CERTFILES=$FABRIC_CFG_PATH/crypto-config/ordererOrganizations/fabric.com/ca/ca.fabric.com-cert.pem
export FABRIC_CA_CLIENT_HOME=$FABRIC_CFG_PATH/fabca/fabric.com/ca-admin

fabric-ca-client enroll -d -u https://rca-orderer-admin:rca-orderer-adminpw@0.0.0.0:7152
fabric-ca-client register -d --id.name orderer1.fabric.com --id.secret ordererpw --id.type orderer -u https://0.0.0.0:7152
fabric-ca-client register -d --id.name Admin@fabric.com --id.secret ordereradminpw --id.type admin --id.attrs "hf.Registrar.Roles=client,hf.Registrar.Attributes=*,hf.Revoker=true,hf.GenCRL=true,admin=true:ecert,abac.init=true:ecert" -u https://0.0.0.0:7152

# enroll peer org po1.fabric.com in ca
export FABRIC_CA_CLIENT_TLS_CERTFILES=$FABRIC_CFG_PATH/crypto-config/peerOrganizations/po1.fabric.com/ca/ca.po1.fabric.com-cert.pem
export FABRIC_CA_CLIENT_HOME=$FABRIC_CFG_PATH/fabca/po1.fabric.com/ca-admin


fabric-ca-client enroll -d -u https://rca-po1-admin:rca-po1-adminpw@0.0.0.0:7153
fabric-ca-client register -d --id.name peer0.po1.fabric.com --id.secret peer1PW --id.type peer -u https://0.0.0.0:7153
fabric-ca-client register -d --id.name peer1.po1.fabric.com --id.secret peer2PW --id.type peer -u https://0.0.0.0:7153
fabric-ca-client register -d --id.name Admin@po1.fabric.com --id.secret po1AdminPW --id.type admin --id.attrs "hf.Registrar.Roles=client,hf.Registrar.Attributes=*,hf.Revoker=true,hf.GenCRL=true,admin=true:ecert,abac.init=true:ecert" -u https://0.0.0.0:7153
fabric-ca-client register -d --id.name User1@po1.fabric.com --id.secret po1UserPW --id.type user -u https://0.0.0.0:7153

fabric-ca-client identity list
