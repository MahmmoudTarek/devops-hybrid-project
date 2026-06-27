pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
   
        stage('Workspace Info') {
          steps {
             sh '''
             echo "WORKSPACE=$WORKSPACE"
             pwd
             ls -la "$WORKSPACE"
             '''
          }
        }

        stage('Terraform Init') {
          steps {
                dir('terraform') {
                    withCredentials([
                        [$class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws-creds']
                    ]) {
                        sh '''
                            terraform init
                        '''
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    withCredentials([
                        [$class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws-creds']
                    ]) {
                        sh '''
                            terraform plan
                        '''
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    withCredentials([
                        [$class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws-creds']
                    ]) {
                        sh '''
                            terraform apply -auto-approve
                        '''
                    }
                }
            }
        }

        stage('Wait for EC2') {
            steps {
                echo 'Waiting for cloud-init...'
                sleep(time: 90, unit: 'SECONDS')
            }
        }

        stage('Ansible Deploy') {
            steps {
                dir('ansible') {
                    sh '''
                        ansible --version
                        ansible-playbook -i inventory/hosts.ini site.yml
                    '''
                }
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
                dir('terraform') {
                    sh '''
                        terraform output
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }

        failure {
            echo 'Pipeline failed.'
        }
    }
}
