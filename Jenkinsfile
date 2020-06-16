node {
  withCredentials([file(credentialsId: 'terrafom2-auth', variable: 'login')]){
    sh "mkdir -p /home/jenkins/agent/workspace/creds"
    sh "cp \$login /home/jenkins/agent/workspace/creds/serviceaccount.json"
    sh "cat /home/jenkins/agent/workspace/creds/serviceaccount.json"
  }
}

pipeline {

  agent any

  environment {
    SVC_ACCOUNT_KEY = credentials('terraform-auth')
  }

  stages {
    
    stage('Checkout') {
      steps {
        checkout scm
        sh 'cat /home/jenkins/agent/workspace/creds/serviceaccount.json'
      }
    }

    stage('TF Plan') {
      steps {
        container('terraform') {
          sh 'terraform init'
          sh 'terraform plan -out myplan'
        }
      }      
    }

    stage('Approval') {
      steps {
        script {
          def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
        }
      }
    }

    stage('TF Apply') {
      steps {
        container('terraform') {
          sh 'terraform apply -input=false myplan'
        }
      }
    }

  } 

}
