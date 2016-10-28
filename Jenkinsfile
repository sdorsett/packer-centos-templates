node ('packer.clifflabs.local') {
    checkout scm

    parallel (
      phase1: {
        echo "Build CentOS 6.8 Puppet Enterprise 3.8.2 template" 
        sh "./jenkins_job_centos-6.8-puppet-4.3.2.sh" 
      },
      phase2: { 
        echo "Build CentOS 6.8 Puppet 4.3.2 template"
        sh "echo p2; sleep 40s; echo phase2" 
      }
    )
    echo "Builds completed"
}
