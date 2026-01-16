pipeline {
    agent any

    stages {
        stage('Trivy Scan Terraform') {
            steps {
                sh '''
                docker run --rm \
                  -v $(pwd):/CREDITFLOWEMI:z \
                  aquasec/trivy:latest \
                  config /CREDITFLOWEMI/terraform || true
                '''
            }
        }
    }
}
