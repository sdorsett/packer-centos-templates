#!/bin/bash
sudo yum upgrade ca-certificates -y
sudo yum install perl bc open-vm-tools -y
sudo ln -s /usr/bin/vmtoolsd /usr/sbin/vmtoolsd

cd /tmp
rm /tmp/vmware-tools-linux.iso
