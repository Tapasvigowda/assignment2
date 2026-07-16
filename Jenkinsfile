pipeline {
    agent any

    environment {
        IMAGE_NAME = "node-app"
        CONTAINER_NAME = "node-app"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url:' https://github.com/Tapasvigowda/assignment2.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:latest .'
            }
        }

        stage('Stop & Remove Old Container') {
            steps {
                sh '''
                docker stop ${CONTAINER_NAME} || true
                docker rm ${CONTAINER_NAME} || true
                '''
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker run -d \
                --name ${CONTAINER_NAME} \
                -p 3000:3000 \
                -e NODE_ENV=production \
                ${IMAGE_NAME}:latest
                '''
            }
        }
    }

    post {
        success {
            echo 'Deployment Successful!'
        }
        failure {
            echo 'Pipeline Failed!'
        }
    }
}
