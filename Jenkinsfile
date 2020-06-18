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

    stage('Initialize'){
        def dockerHome = tool 'Docker'
        env.PATH = "${dockerHome}/bin:${env.PATH}"
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
    // stage('checkout') {
    //   steps {
    //   git branch: 'master', url: 'https://github.com/nitrouskiller/nodemongocicd.git'
      
    //   }
    // }
    // stage('Setting Terraform Path'){
    //   steps{
    //     script {
    //       def tfHome = tool name: 'Terraform'
    //       env.PATH = "${tfHome}:${env.PATH}"
    //     }
    //   sh 'terraform —v'
    //   }
    // }
  }
}
