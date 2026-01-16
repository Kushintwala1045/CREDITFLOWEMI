pipeline {
    agent any

    stages {
        stage('Trivy Scan Terraform') {
            steps {
                sh '''
                docker run --rm \
                  -v $(pwd):/project \
                  aquasec/trivy:latest \
                  config /project/terraform || true
                '''
            }
        }
    }
}
