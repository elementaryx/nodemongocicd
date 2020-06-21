pipeline {
  environment {
    registry = "adrenalinerush/nodeapp"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/nitrouskiller/nodemongocicd.git'
      }
    }

    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
    stage('checkout') {
      steps {
      git branch: 'master', url: 'https://github.com/nitrouskiller/nodemongocicd.git'
      
      }
    }
    // stage('Setting Terraform Path'){
    //   steps{
    //     script {
          
    //       env.PATH = "/bin/terraform"
    //     }
    //   sh 'terraform —version'
    //   }
    // }

    stage('Terraform Init') {
      steps {
        sh "terraform init -input=false Terraform/"
      }
    }
    stage('Terraform Plan') {
      steps {
        sh "terraform plan -out=tfplan -input=false Terraform/"
      }
    }
    stage('Terraform Apply') {
      steps {
        input 'Apply Plan'
        sh "terraform apply -input=false tfplan Terraform/"
      }
    }

  }
}
