pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        AWS_DEFAULT_REGION = 'us-east-1'
    }
       

   stages {

       stage('AWS Ttest') {
          steps {
             sh '''
             aws sts get-caller-identity
             '''
           }
       }
       stage('AWS Test') {
            steps {
               sh '''
               echo "Region: $AWS_DEFAULT_REGION"

               if [ -z "$AWS_ACCESS_KEY_ID" ]; then
               echo "AWS_ACCESS_KEY_ID is empty"
               exit 1
               fi

               aws sts get-caller-identity
               '''
            }
       }
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
