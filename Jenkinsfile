pipeline {
    agent any
    parameters {
  choice choices: ['Apply', 'Destroy'], name: 'Infra'
}

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
        stage('terraform destroy'){
            when {
               
                expression { params.Infra == 'Destroy' }
            }
            script{
                  steps {
                sh 'terraform destroy --auto-approve'
            }
             steps {
        // Abort the build, skipping subsequent stages
        error("Build Aborted Infra Destroyed ${params.Infra}")
              }
            }
          
       }
        stage('terraform apply'){
             when {
               
                expression { params.Infra == 'Apply' }
            }
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
       stage('Copy data'){
            steps {
                sh'''
                IP=$(terraform output -json public_config_ec2 | jq -s -r '.[]')
                echo $IP
                ssh -i "/var/lib/jenkins/haproxy.pem" -o StrictHostKeyChecking=no -tt ubuntu@$IP "rm -rf Invnetory haproxy.pem"
                scp -i "/var/lib/jenkins/haproxy.pem" -o StrictHostKeyChecking=no -r /var/lib/jenkins/workspace/FinalTool/Invnetory ubuntu@$IP:~
                scp -i "/var/lib/jenkins/haproxy.pem" -o StrictHostKeyChecking=no -r /var/lib/jenkins/haproxy.pem ubuntu@$IP:~
                '''
            }
        }
        stage('Git clone'){
            steps {
                sh'''
                IP=$(terraform output -json public_config_ec2 | jq -s -r '.[]')
                echo $IP
                ssh -i "/var/lib/jenkins/haproxy.pem" -o StrictHostKeyChecking=no -tt ubuntu@$IP "rm -rf Ansible"
                ssh -i "/var/lib/jenkins/haproxy.pem" -o StrictHostKeyChecking=no -tt ubuntu@$IP "git clone https://github.com/Sanyam-Kalra/Ansible.git"
                '''
            }
        }
        stage('Configure ansible'){
            steps {
                sh'''
                IP=$(terraform output -json public_config_ec2 | jq -s -r '.[]')
                echo $IP
                ssh -i "/var/lib/jenkins/haproxy.pem" -o StrictHostKeyChecking=no -tt ubuntu@$IP "sudo apt update -y && sudo apt-add-repository ppa:ansible/ansible -y && sudo apt install ansible -y"
                '''
            }
        }
        stage('Role setup'){
            steps {
                sh'''
                 IP=$(terraform output -json public_config_ec2 | jq -s -r '.[]')
                echo $IP
                ssh -i "/var/lib/jenkins/haproxy.pem" -o StrictHostKeyChecking=no -tt ubuntu@$IP "ansible-playbook -i Invnetory ~/Ansible/tool.yml"
                '''
            }
        }
    }
}
  
