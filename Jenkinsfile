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
          // dockerImage = docker.build registry + ":$BUILD_NUMBER"
          dockerImage = docker.build registry + ":latest"
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
        // sh "docker rmi $registry:$BUILD_NUMBER"
        sh "docker rmi $registry:latest"
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
        sh "terraform plan -out=tfplan -var AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -var AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -input=false Terraform/"
      }
    }
    stage('Terraform Apply') {
      steps {
        sh "terraform apply -auto-approve -var AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -var AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY Terraform/"
      }
    }

    // stage('Running docker ') {
    //   steps {
    //     sh "wget https://github.com/nitrouskiller/nodemongocicd/blob/master/docker-compose.yml"
    //     sh "docker-compose up -d"
    //   }
    // }

  }
}
