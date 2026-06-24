pipeline {
agent any


stages {

    stage('Checkout') {
        steps {
            git branch: 'master',
                credentialsId: 'github-ssh',
                url: 'git@github.com:MahmmoudTarek/devops-hybrid-project.git'
        }
    }

    stage('Terraform Validate') {
        steps {
            sh '''
            cd terraform
            terraform init
            terraform validate
            '''
        }
    }

    stage('Ansible Check') {
        steps {
            sh '''
            cd ansible
            ansible-playbook site.yml --syntax-check
            '''
        }
    }

    stage('Deploy App') {
        steps {
            sh '''
            ./deploy.sh
            '''
        }
    }

    stage('Verify') {
        steps {
            sh '''
            docker ps
            '''
        }
    }
}


}

