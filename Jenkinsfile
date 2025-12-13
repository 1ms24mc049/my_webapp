pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    IMAGE_NAME = "1ms24mc049/my_webapp"
  }

  stages {
    stage('Checkout') {
      steps {
        git(
          url: 'https://github.com/1ms24mc049/my_webapp',
          branch: 'master',
          credentialsId: 'dockerhub'
        )
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          dockerImage = docker.build("${IMAGE_NAME}:latest")
        }
      }
    }

    stage('Push to Docker Hub') {
      steps {
        script {
          docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
            dockerImage.push()
          }
        }
      }
    }
  }

  post {
    always {
      echo "Cleaning up workspace..."
      deleteDir()
    }
    success {
      echo 'Pipeline succeeded!'
    }
    failure {
      echo 'Pipeline failed!'
    }
  }
}
