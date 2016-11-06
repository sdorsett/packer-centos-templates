#!/bin/bash

VERSION=`git describe | cut -d '-' -f 1`
BUILD=`git describe | cut -d '-' -f 2`
PADDEDBUILD=`printf %04d $BUILD`

# Ensure the following environmental variables are defined
# and reflect the vcenter that the .ova will be deployed to:
# VSPHERE_USERNAME="administrator@vsphere.local"
# VSPHERE_PASSWORD="****"
# VSPHERE_HOST="192.168.1.254"
# VSPHERE_DC="datacenter-name"
# VSPHERE_CLUSTER="cluster-name"
# VSPHERE_DATASTORE="datastore-name"
# VSPHERE_NETWORK="portgroup-name"
# To make this easier I have these defined in /root/.env and I just source this file:
source /root/.env

echo "Deploying ${OVA_NAME}-${VERSION}-${PADDEDBUILD}.ova to vcenter ${VSPHERE_HOST}"

ovftool --skipManifestCheck --acceptAllEulas --disableVerification --noSSLVerify --datastore=${VSPHERE_DATASTORE} --network=${VSPHERE_NETWORK} --name=${OVA_NAME} --overwrite /root/packer-build-artifacts/${OVA_NAME}-${VERSION}-${PADDEDBUILD}.ova vi://${VSPHERE_USERNAME}:${VSPHERE_PASSWORD}@${VSPHERE_HOST}/${VSPHERE_DC}/host/${VSPHERE_CLUSTER}
