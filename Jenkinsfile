pipeline {
    agent any

    environment {
        // Use the IDs you created in Jenkins Credentials (Secret text)
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        AWS_DEFAULT_REGION    = 'us-east-1' 
    }

    stages {
        stage('Checkout Source') {
            steps {
                checkout scm
            }
        }

        stage('Trivy Security Scan') {
            steps {
                script {
                    echo "Scanning Infrastructure for vulnerabilities..."
                    // This will FAIL the build if it finds HIGH/CRITICAL flaws
                    // Use this output for your AI remediation task
                    sh 'trivy config --exit-code 1 --severity HIGH,CRITICAL ./terraform'
                }
            }
        }

        stage('Terraform Deploy') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    // This creates the actual resources on AWS
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }

    post {
        success {
            echo "Deployment Successful! Check AWS Console for your Public IP."
        }
        failure {
            echo "Pipeline Failed. If it failed at 'Trivy Scan', use the log for AI remediation."
        }
    }
}