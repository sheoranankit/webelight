pipeline {
    agent any
    environment {
        // Define environment variables
        REMOTE_SERVER = '15.206.168.162'
        REMOTE_USER = 'ubuntu'
        DOCKER_IMAGE_NAME = 'sheoran8744/webelight'
        DOCKERFILE_PATH = 'webelight/Dockerfile'
    }
    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from your version control system (e.g., Git)
                checkout scm
            }
        }

        stage('Build') {
            steps {
                // Build Docker image
                script {
                    sh 'scp build.sh ${REMOTE_USER}@${REMOTE_SERVER}:/tmp/.'
                    sh 'ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_SERVER} "set -x; sudo su; chmod +x /tmp/*.sh; if ! sudo /tmp/build.sh; then echo 'build is failed'; exit 1; else echo 'build is successful'; fi"'
                }
            }
        }

        stage('Deploy to Docker Registry') {
            steps {
                // Push Docker image to a registry (if needed)
                script {
                    docker.withRegistry('https://index.docker.io/v1/', '05885758-9964-470a-b6d6-7878c99dbe38') {
                        docker.image("${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}").push()
                    }
                }
            }
        }

        stage('Deploy to Remote Server') {
            steps {
                script {
                    // Deploy the Docker container on the remote server
                    sh "ssh ${NODE_NAME} 'mkdir -p ${REMOTE_DIR}'"
                    sh "scp ${DOCKERFILE_PATH} ${NODE_NAME}:${REMOTE_DIR}"
                    sh "scp docker-compose.yml ${NODE_NAME}:${REMOTE_DIR}" // if using Docker Compose
                    sh "scp .env ${NODE_NAME}:${REMOTE_DIR}" // if using environment variables
                    sh "ssh ${NODE_NAME} 'cd ${REMOTE_DIR} && docker-compose up -d'"
                    // Add any additional deployment steps
                }
            }
        }
    }

    post {
        always {
            // Clean up or perform post-build actions
            sh 'echo "Build and deployment completed"'
        }
    }
}