pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    def appImage = docker.build('file-storage-app')

                    // Tag the image for Docker Hub
                    appImage.tag("dockerhub_username/file-storage-app:${env.BUILD_NUMBER}")

                    // Push the image to Docker Hub
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_credentials') {
                        appImage.push()
                    }
                }
            }
        }
        stage('Deploy') {
            environment {
                KUBECONFIG = credentials('kubeconfig_credentials')
            }
            steps {
                script {
                    def kubeconfigPath = writeKubeconfig environment.KUBECONFIG

                    // Deploy to Kubernetes cluster
                    sh "kubectl --kubeconfig=${kubeconfigPath} apply -f file-storage-app-deployment.yaml"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
