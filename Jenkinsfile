pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from your version control system (e.g., Git)
                sshagent(['dbe55d01-34c6-4469-a746-b1717199f312']){
                sh "ssh ${REMOTE_USER}@${REMOTE_SERVER} 'git pull origin main'"
                }
            }
        }

        stage('Build') {
            steps {
                sshagent(['dbe55d01-34c6-4469-a746-b1717199f312']){
                // Execute build commands
                sh 'docker build -t sheoran8744/webelight:1'
                sh 'docker push sheoran8744/webelight:1'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // SSH into the remote server and deploy the application
                    sshagent(['dbe55d01-34c6-4469-a746-b1717199f312']) {
                        sh "ssh ${REMOTE_USER}@${REMOTE_SERVER} 'mkdir -p ${REMOTE_DIR}'"
                        sh "scp target/your_application.jar ${REMOTE_USER}@${REMOTE_SERVER}:${REMOTE_DIR}"
                        // Add any additional deployment steps
                    }
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
