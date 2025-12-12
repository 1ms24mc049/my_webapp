pipeline {
  agent any

  environment {
    // Jenkins credential id for Docker Hub (username/password)
    DOCKERHUB_CREDENTIALS = 'dockerhub'
    // change if you want a different image name
    IMAGE_NAME = "1ms24mc049/my_webapp"
  }

  stages {
    stage('Checkout') {
      steps {
        // Use the SCM configured in the Jenkins job (recommended)
        checkout scm
      }
    }

    stage('Build (Maven)') {
      steps {
        // Build your project and create classes/jar
        sh 'mvn -B -DskipTests clean package'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          // Tag image with build number for uniqueness
          dockerImage = docker.build("${IMAGE_NAME}:${env.BUILD_NUMBER}")
        }
      }
    }

    stage('Push to Docker Hub') {
      steps {
        script {
          // Use the Docker Hub credentials stored in Jenkins
          docker.withRegistry('', "${DOCKERHUB_CREDENTIALS}") {
            dockerImage.push("${env.BUILD_NUMBER}")
            // also push 'latest' if you want a stable tag
            dockerImage.push('latest')
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
      echo "Pipeline succeeded: ${IMAGE_NAME}:${env.BUILD_NUMBER} pushed"
    }
    failure {
      echo 'Pipeline failed!'
    }
  }
}
