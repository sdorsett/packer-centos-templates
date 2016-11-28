#!/bin/bash
sudo yum upgrade ca-certificates -y
sudo yum install perl bc open-vm-tools -y

cd /tmp
rm /tmp/vmware-tools-linux.iso
