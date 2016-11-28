#!/bin/bash
sudo yum upgrade ca-certificates -y
sudo yum install perl bc -y
sudo mkdir /mnt/cdrom 
sudo mount -o loop /tmp/vmware-tools-linux.iso /mnt/cdrom
sudo cp /mnt/cdrom/VMwareTools*.tar.gz /tmp/
cd /tmp
tar xfz VMwareTools*.tar.gz
cd /tmp/vmware-tools-distrib
ls -la

sudo /tmp/vmware-tools-distrib/vmware-install.pl -d

sudo umount /mnt/cdrom
cd /tmp
rm -rf vmware-tools-distrib
rm -f VMwareTools*.tar.gz
rm /tmp/vmware-tools-linux.iso
