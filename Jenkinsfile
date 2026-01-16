pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // IMPORTANT: You must pull the code first!
                checkout scm 
            }
        }
        stage('Trivy Scan Terraform') {
            steps {
                sh '''
                # 1. Print the current directory to verify where we are
                echo "Current Workspace: $(pwd)"
                
                # 2. List files to confirm the terraform folder exists
                ls -F
                
                # 3. Run Trivy mapping the CURRENT directory to /root
                docker run --rm \
                  -v $(pwd):/root \
                  aquasec/trivy:latest \
                  config /root/terraform || true
                '''
            }
        }
    }
}