pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        AWS_DEFAULT_REGION = 'us-east-1'
    }


    stages {

        stage('Checkout') {
            steps {
                git branch: 'master',
                    credentialsId: 'github-ssh',
                    url: 'git@github.com:MahmmoudTarek/devops-hybrid-project.git'
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

        stage('Ansible Deploy') {
            steps {
                sh '''
                cd ansible
                ansible-playbook -i inventory/hosts.ini site.yml
                '''
            }
        }

        stage('Deploy Application') {
            steps {
                sh '''
                chmod +x deploy.sh
                ./deploy.sh
                '''
            }
        }

        stage('Verify') {
            steps {
                sh '''
                docker ps
                curl http://localhost:8080
                '''
            }
        }
    }
}
