pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id')
        IMAGE_NAME = "hamzah64/ml-ci-cd-pipeline"
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    bat "docker build -t %IMAGE_NAME%:latest ."
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    bat "echo %DOCKERHUB_CREDENTIALS_PSW% | docker login -u %DOCKERHUB_CREDENTIALS_USR% --password-stdin"
                    bat "docker push %IMAGE_NAME%:latest"
                }
            }
        }
    }

    post {
    success {
        echo "Deployment Successful!"
        emailext subject: "Jenkins Deployment Success ✅",
                 body: "The Docker image has been successfully built and pushed to Docker Hub.",
                 recipientProviders: [developers(), requestor()]
    }
    failure {
        echo "Deployment Failed ❌"
        emailext subject: "Jenkins Deployment Failed ❌",
                 body: "The Docker build or push failed. Check Jenkins logs.",
                 recipientProviders: [developers(), requestor()]
    }
}

}
