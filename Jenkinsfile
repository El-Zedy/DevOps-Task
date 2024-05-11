pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'java-application'
        CONTAINER_NAME = 'java-app-container'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Building the Docker image
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Check if the container is already running
                    sh(script: "docker ps -q --filter name=${CONTAINER_NAME} | xargs --no-run-if-empty docker stop", returnStatus: true)
                    sh(script: "docker ps -aq --filter name=${CONTAINER_NAME} | xargs --no-run-if-empty docker rm", returnStatus: true)
                    // Run the Docker container
                    sh "docker run -d --name ${CONTAINER_NAME} ${DOCKER_IMAGE}"
                }
            }
        }
    }
    post {
        always {
            // Clean up Docker images and containers after the pipeline execution
            sh(script: "docker ps -aq --filter name=${CONTAINER_NAME} | xargs --no-run-if-empty docker rm -f", returnStatus: true)
            sh(script: "docker images -q ${DOCKER_IMAGE} | xargs --no-run-if-empty docker rmi", returnStatus: true)
        }
    }
}
