pipeline {
    agent any

    tools { 
        maven '3.9.6' 
    }

    environment {
        IMAGE_NAME = 'java-application'
        IMAGE_TAG = "${IMAGE_NAME}:${env.BUILD_NUMBER}"
        CONTAINER_NAME = 'java-app-container'
    }

    stages {
        stage('Build and SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonarQube') {
                    sh 'mvn clean package sonar:sonar'
                }
            }
        }
        stage('Quality Gate') {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_TAG} ."
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    sh "docker rm -f ${CONTAINER_NAME} || true"
                    sh "docker run -d --name ${CONTAINER_NAME} ${IMAGE_TAG}"
                }
            }
        }
    }
}
