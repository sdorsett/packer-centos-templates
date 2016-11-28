#!/bin/bash

VERSION=`git describe | cut -d '-' -f 1`
BUILD=`git describe | cut -d '-' -f 2`
PADDEDBUILD=`printf %04d $BUILD`

mkdir iso/

# the following .iso files need to be located at /root/install_iso/. sha1 hash is included for reference
# 783eef50e1fb91c78901d0421d8114a29b998478  /root/install_iso/CentOS-7-x86_64-Minimal-1511.iso
# 9c1124f1521c6ac079819a5634745426b681912d  /root/install_iso/vmware-tools-linux.iso
cp /root/packer_iso_files/* iso/

echo "###### build the vuaas packer template - centos-70-puppet-432-$VERSION-$PADDEDBUILD.ova ######"
packer build -var-file=/root/packer-remote-info.json templates/centos-7.0-puppet-4.3.2.json

echo "###### add vapp properties to .ovf file ######"
sed -i -e '/  <\/VirtualSystem>/d' centos-70-puppet-432/centos-70-puppet-432/centos-70-puppet-432.ovf
sed -i -e '/<\/Envelope>/d' centos-70-puppet-432/centos-70-puppet-432/centos-70-puppet-432.ovf 
sed -i -e 's/<VirtualHardwareSection>/<VirtualHardwareSection ovf:transport="com.vmware.guestInfo">/g' centos-70-puppet-432/centos-70-puppet-432/centos-70-puppet-432.ovf 
cat << EOF >> centos-70-puppet-432/centos-70-puppet-432/centos-70-puppet-432.ovf
    <ProductSection>
      <Info>Information about the installed software</Info>
      <Product>centos-70-puppet-432</Product>
      <Version>$VERSION</Version>
      <FullVersion>$VERSION-$PADDEDBUILD</FullVersion>
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

echo "###### delete centos-70-puppet-432-$VERSION-$PADDEDBUILD.ova if it exists  ######"
rm -rf /root/packer-build-artifacts/centos-70-puppet-432-$VERSION-$PADDEDBUILD.ova

echo "###### convert the multiple exported .ovf files to a single .ova file ######"
ovftool --skipManifestCheck centos-70-puppet-432/centos-70-puppet-432/centos-70-puppet-432.ovf /root/packer-build-artifacts/centos-70-puppet-432-$VERSION-$PADDEDBUILD.ova

echo "###### clean up build directory ######"
rm -rf /root/packer-centos-templates/centos-70-puppet-432
rm -rf /home/jenkins/workspace/centos-70-puppet-432

