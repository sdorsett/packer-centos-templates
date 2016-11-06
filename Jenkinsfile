node ('packer.clifflabs.local') {
    checkout scm

    stage ('Build CentOS 6.8 Puppet 4.3.2 template') {
      echo "Build CentOS 6.8 Puppet 4.3.2 template" 
      sh "./jenkins_job_centos-6.8-puppet-4.3.2.sh" 
    }
    stage ('Build CentOS 6.8 Puppet Enterprise 3.8.2 template') {
      echo "Build CentOS 6.8 Puppet Enterprise 3.8.2 template"
      sh "./jenkins_job_centos-6.8-pe-puppet-3.8.2.sh" 
    }
    stage ('Clean up workspace') {
      echo "Clean up workspace"
      sh "#rm -rf /home/jenkins/*"
    }
    echo "Builds completed"

}
