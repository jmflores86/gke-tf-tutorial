node {
  withCredentials([file(credentialsId: 'terraform2-auth', variable: 'my-auth'){
   sh "cp \$my-auth ./creds/serviceaccount.json"
  }
}

pipeline {

  agent any

  environment {
    SVC_ACCOUNT_KEY = credentials('terraform-auth')
  }

  stages {

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
