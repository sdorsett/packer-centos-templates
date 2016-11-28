### packer-centos-templates

This repository contains templates for creating the following CentOS templates on ESXi using Packer:
* CentOS 6.8 with vmtools and puppet enterprise 3.8.2 agent installed
* Centos 6.8 with vmtools and puppet open source 4.3.2 agent installed
* CentOS 7.1 with vmtools and puppet open source 4.3.2 agent isntalled

These templates have been successfully created with Packer 0.12.0. 

In order to prevent any credentials or environmental information from getting into this repository, you will need to create the following files:

* /root/packer-remote-info.json - used to provide the information needed about the ESXi host used to create the templates
* /root/.env - used to provide vSphere information if you want to deploy the created templates to a vSphere instance

Here is an example of what each of these files should look like:

```
[root@packer /]# cat /root/packer-remote-info.json 
{
  "packer_remote_host": "192.168.1.100",
  "packer_remote_username": "root",
  "packer_remote_password": "vmware",
  "packer_remote_datastore": "datastore-01",
  "packer_remote_network": "vm-network",
}
[root@packer /]# 
```
 
```
[root@packer /]# cat /root/.env
VSPHERE_USERNAME="vagrant@vsphere.local"
VSPHERE_PASSWORD="vmware"
VSPHERE_HOST="192.168.1.50"
VSPHERE_DC="datacenter-01"
VSPHERE_CLUSTER="cluster-01"
VSPHERE_DATASTORE="datastore-01"
VSPHERE_NETWORK="vm-network"
[root@packer /]# 
```

You will also need to add the following files into /root/packer_iso_files/
* CentOS-6.8-x86_64-minimal.iso ( sha1 checksum 28cd663c2267676414496f0929ce7bb285bf2506 ) 
* CentOS-7-x86_64-Minimal-1511.iso ( sha1 checksum 783eef50e1fb91c78901d0421d8114a29b998478 )
* vmware-tools-linux.iso ( This is the latest vmtools linux iso _
* puppet-enterprise-3.8.2-el-6-x86_64.tar.gz ( optional, if this file is not prestaged, it will be downloaded during each packer run )

The following scripts can be run from the root folder of this respository to create the Packer templates:
* jenkins_scripts/packer_build_centos-6.8-pe-puppet-3.8.2.sh
* jenkins_scripts/packer_build_centos-6.8-puppet-4.3.2.sh
* jenkins_scripts/packer_build_centos-7.0-puppet-4.3.2.sh

The Jenkinsfile in this repository can also be used to create a Jenkins Pipeline to automatically create all the templates when a change is merged into the repository.

