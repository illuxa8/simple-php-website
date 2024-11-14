pipeline {
    agent any

    environment {
        registry = 'illuxa2024'        // Ваш Docker Hub username
        imageName = 'vis'              // Ім'я вашого репозиторію на Docker Hub
        dockerImage = "${registry}/${imageName}"  // Формуємо повний шлях до образу
        DOCKER_PASSWORD = '112233illya'     // Ваш Docker Hub пароль (небезпечно для продакшн середовища)
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    checkout scm
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    sh "docker build -t ${dockerImage} ."
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    sh "docker login -u ${registry} -p ${DOCKER_PASSWORD}"
                    sh "docker push ${dockerImage}"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh 'docker-compose down'
                    sh 'docker-compose up -d --build'
                }
            }
        }
    }
}
