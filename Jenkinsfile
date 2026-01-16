pipeline {
    agent any

    environment {
        // Path to your terraform folder in the repo
        TF_PATH = 'terraform'
    }

    stages {
        stage('Checkout Source Code') {
            steps {
                // REQUIRED: Pulls your 'Inclusive Connect' code from GitHub
                checkout scm
            }
        }

        stage('Infrastructure Security Scan (Trivy)') {
            steps {
                script {
                    echo "Current Workspace: ${WORKSPACE}"
                    // We use the full WORKSPACE path to ensure the Docker container 
                    // maps the correct physical location to its internal /apps folder.
                    sh """
                    docker run --rm \
                      -v ${WORKSPACE}:/apps \
                      aquasec/trivy:latest \
                      config /apps/${TF_PATH}
                    """
                }
            }
        }

        stage('Terraform Init & Plan') {
            steps {
                // Using the 'dir' block ensures Jenkins runs these commands 
                // inside your terraform folder
                dir("${TF_PATH}") {
                    sh 'terraform init'
                    sh 'terraform plan'
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline finished. Check 'Security Scan' logs for the AI remediation task."
        }
    }
}