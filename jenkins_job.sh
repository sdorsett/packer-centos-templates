#!/bin/bash

VERSION=`git describe | cut -d '-' -f 1`
BUILD=`git describe | cut -d '-' -f 2`
PADDEDBUILD=`printf %04d $BUILD`

mkdir iso/

# the following .iso files need to be located at /root/install_iso/. sha1 hash is included for reference
# 28cd663c2267676414496f0929ce7bb285bf2506  /root/install_iso/CentOS-6.8-x86_64-minimal.iso
# 9c1124f1521c6ac079819a5634745426b681912d  /root/install_iso/vmware-tools-linux.iso
cp /root/packer_iso_files/* iso/

echo "###### build the vuaas packer template ######"
packer build -var-file=/root/packer-remote-info.json templates/centos-6.8-pe-puppet-3.8.2.json

echo "###### add vapp properties to .ovf file ######"
sed -i -e '/  <\/VirtualSystem>/d' vuaas-template/vuaas-template/vuaas-template.ovf
sed -i -e '/<\/Envelope>/d' vuaas-template/vuaas-template/vuaas-template.ovf
sed -i -e 's/<VirtualHardwareSection>/<VirtualHardwareSection ovf:transport="com.vmware.guestInfo">/g' vuaas-template/vuaas-template/vuaas-template.ovf
cat << EOF >> vuaas-template/vuaas-template/vuaas-template.ovf
    <ProductSection>
      <Info>Information about the installed software</Info>
      <Category>Network</Category>
      <Property ovf:key="hostname" ovf:type="string" ovf:userConfigurable="true">
        <Label>hostname</Label>
        <Description>FQDN (fully-qualified domain name)</Description>
      </Property>
      <Property ovf:key="ip_address" ovf:type="string" ovf:userConfigurable="true">
        <Label>ip_address</Label>
        <Description>dotted quad notation</Description>
      </Property>
      <Property ovf:key="gateway" ovf:type="string" ovf:userConfigurable="true">
        <Label>gateway</Label>
        <Description>dotted quad notation; default gateway</Description>
      </Property>
      <Property ovf:key="netmask" ovf:type="string" ovf:userConfigurable="true">
        <Label>netmask</Label>
        <Description>dotted quad notation</Description>
      </Property>
      <Property ovf:key="dns_servers" ovf:type="string" ovf:userConfigurable="true">
        <Label>dns_servers</Label>
        <Description>dotted quad notation; comma-separated list</Description>
      </Property>
      <Property ovf:key="domain" ovf:type="string" ovf:userConfigurable="true">
        <Label>domain</Label>
        <Description>(optional) search domain</Description>
      </Property>
      <Property ovf:key="interface" ovf:type="string" ovf:userConfigurable="true" ovf:value="eth0">
        <Label>interface</Label>
        <Description>(optional) interface; example: eth0</Description>
      </Property>
      <Property ovf:key="puppetmaster" ovf:type="string" ovf:userConfigurable="true">
        <Label>puppetmaster</Label>
        <Description>(optional) fully-qualified domain name of the puppet master that will configure this system</Description>
      </Property>
    </ProductSection>
  </VirtualSystem>
</Envelope>
EOF

echo "###### convert the multiple exported .ovf files to a single .ova file ######"
ovftool --skipManifestCheck vuaas-template/vuaas-template/vuaas-template.ovf /root/packer-build-artifacts/vuaas-deploy-$VERSION-$PADDEDBUILD.ova

#echo "###### clean up build directory ######"
#rm -rf /root/packer-templates/vuaas-template
#rm -rf /root/packer-build-artifacts/vuaas-deploy-$BUILD_NUMBER.ova
#rm -rf /home/jenkins/workspace/vuaas-packer-build
