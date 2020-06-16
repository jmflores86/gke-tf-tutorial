node {
  withCredentials([file(credentialsId: 'terrafom2-auth', variable: 'login')]){
   sh "cp \$login /src/main/resources/serviceaccount.json"
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
        sh 'mkdir -p creds' 
        sh 'cat /src/main/resources/serviceaccount.json | base64 -d > ./creds/serviceaccount.json'
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
