node ('packer.clifflabs.local') {
    checkout scm

    stage ('Build CentOS 6.8 Puppet 4.3.2 template') {
      echo "Build CentOS 6.8 Puppet 4.3.2 template" 
      sh "jenkins_scripts/packer_build_centos-6.8-puppet-4.3.2.sh" 
      sh "OVA_NAME='centos-68-puppet-432' jenkins_scripts/vcenter_deploy_ova.sh"
    }
    stage ('Build CentOS 6.8 Puppet Enterprise 3.8.2 template') {
      echo "Build CentOS 6.8 Puppet Enterprise 3.8.2 template"
      sh "jenkins_scripts/packer_build_centos-6.8-pe-puppet-3.8.2.sh" 
      sh "OVA_NAME='centos-68-pe-puppet-382' jenkins_scripts/vcenter_deploy_ova.sh"
    }
    stage ('Build CentOS 7 Puppet 4.3.2 template') {
      echo "Build CentOS 7 Puppet 4.3.2 template"
      sh "jenkins_scripts/packer_build_centos-7.0-puppet-4.3.2.sh"
      sh "OVA_NAME='centos-70-puppet-432' jenkins_scripts/vcenter_deploy_ova.sh"
    }
    echo "Builds completed"

}
