stage('Trivy Scan Terraform') {
    steps {
        sh '''
        # Use ${WORKSPACE} instead of $(pwd) for better reliability in Jenkins
        docker run --rm \
          -v /var/jenkins_home/workspace/Creditflowemi:/apps \
          aquasec/trivy:latest \
          config /apps/terraform
        '''
    }
}