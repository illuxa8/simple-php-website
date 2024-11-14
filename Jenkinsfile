pipeline {
    agent any

    environment {
        registry = 'illuxa2024'   // Ваш Docker Hub username
        imageName = 'vis'         // Ім'я вашого репозиторію на Docker Hub
        dockerImage = "${registry}/${imageName}"  // Формуємо повний шлях до образу
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout the code from SCM
                    checkout scm
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    // Build Docker image
                    sh "docker build -t ${dockerImage} ."
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    // Login to DockerHub
                    sh "docker login -u ${registry} -p ${DOCKER_PASSWORD}"
                    // Push the Docker image to DockerHub
                    sh "docker push ${dockerImage}"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Rebuild and redeploy Docker containers
                    sh 'docker-compose down'
                    sh 'docker-compose up -d --build'
                }
            }
        }
    }
}
