// Infrastructure tools - builds base Docker images used by other pipelines
// Maintained by DevOps team - ping #devops-support on Slack
node {
    def registry = '145023098958.dkr.ecr.us-east-2.amazonaws.com'

    try {
        stage('Checkout') {
            checkout scm
        }

        stage('Login ECR') {
            sh "aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin ${registry}"
        }

        stage('Build Images') {
            parallel(
                'Node Builder': {
                    sh "docker build -t ${registry}/base-node:${env.BUILD_NUMBER} images/node-builder/"
                    sh "docker push ${registry}/base-node:${env.BUILD_NUMBER}"
                },
                'Python Runner': {
                    sh "docker build -t ${registry}/base-python:${env.BUILD_NUMBER} images/python-runner/"
                    sh "docker push ${registry}/base-python:${env.BUILD_NUMBER}"
                },
                'Go Builder': {
                    sh "docker build -t ${registry}/base-go:${env.BUILD_NUMBER} images/go-builder/"
                    sh "docker push ${registry}/base-go:${env.BUILD_NUMBER}"
                },
                'Java Builder': {
                    sh "docker build -t ${registry}/base-java:${env.BUILD_NUMBER} images/java-builder/"
                    sh "docker push ${registry}/base-java:${env.BUILD_NUMBER}"
                }
            )
        }

        currentBuild.result = 'SUCCESS'
    } catch (Exception e) {
        currentBuild.result = 'FAILURE'
        throw e
    } finally {
        sh 'docker system prune -f || true'
    }
}
