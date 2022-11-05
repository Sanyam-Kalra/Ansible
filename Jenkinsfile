
pipeline {
    agent any
    stages {
        stage('terraform format check') {
            steps{
                sh 'terraform fmt'
            }
        }
        stage('terraform Init') {
            steps{
                sh 'terraform init'
            }
        }
        stage('terraform apply'){
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
        stage('terraform output'){
            steps {
                sh'''
                chmod +x file.sh
                ./file.sh ubuntu /home/ubuntu/haproxy.pem
                 '''
            }
        }
