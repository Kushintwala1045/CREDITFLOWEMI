pipeline {
    agent any

    stages {
        stage('Trivy Scan Terraform') {
            steps {
                // sh 'ls'
                sh 'trivy config --exit-code 1 --severity HIGH,CRITICAL ./terraform'
            }
        }
    }
}