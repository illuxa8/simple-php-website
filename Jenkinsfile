kpipeline {
    agent any

    environment {
        registry = 'illuxa2024'  // Заміни на свій Docker Hub username
        imageName = 'vis'  // Заміни на ім'я твого образу
        dockerImage = "${registry}/${imageName}"
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
                    echo "Building Docker image ${dockerImage}"
                    sh "docker build -t ${dockerImage} ."
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    // Login to DockerHub using Jenkins credentials
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}"
                        sh "docker push ${dockerImage}"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Перевірка наявності docker-compose.yml
                    sh 'ls -alh docker-compose.yml'
                    
                    // Rebuild and redeploy Docker containers
                    sh 'docker-compose down'
                    sh 'docker-compose up -d --build'
                }
            }
        }
    }
}

