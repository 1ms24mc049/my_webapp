pipeline {
  agent any

  environment {
    IMAGE_NAME = "1ms24mc049/my_webapp"
  }

  stages {
    stage('Checkout') {
      steps {
        // If this Jenkinsfile lives in the repo, checkout scm is simplest & reliable
        checkout scm
        // OR, to use a specific Git credential/URL, use:
        // git url: 'https://github.com/1ms24mc049/my_webapp.git', branch: 'main', credentialsId: 'github-creds'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          // Build the image (requires docker on agent)
          dockerImage = docker.build("${IMAGE_NAME}:latest")
        }
      }
    }

    stage('Push to Docker Hub') {
      steps {
        script {
          // Push the 'latest' tag explicitly using Docker Hub credentials (dockerhubID)
          docker.withRegistry('https://registry.hub.docker.com', 'dockerhubID') {
            dockerImage.push('latest')
          }
        }
      }
    }
  }

  post {
    always {
      echo "Cleaning up workspace..."
      // Requires Workspace Cleanup Plugin; otherwise use 'script { deleteDir() }'
      cleanWs()
    }
    success {
      echo 'Pipeline succeeded!'
    }
    failure {
      echo 'Pipeline failed!'
    }
  }
}
