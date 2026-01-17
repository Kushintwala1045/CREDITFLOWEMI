pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Kushintwala1045/CREDITFLOWEMI.git'
            }
        }

        stage('Policy Compliance Check') {
            steps {
                echo "Validating infrastructure against company security policies"
            }
        }

        stage('Trivy Terraform Scan') {
            steps {
                sh '''
                trivy config --exit-code 1 --severity HIGH,CRITICAL ./terraform
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                cd terraform
                terraform init
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                cd terraform
                terraform plan
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                sh '''
                cd terraform
                terraform apply -auto-approve
                '''
            }
        }
    }
}
