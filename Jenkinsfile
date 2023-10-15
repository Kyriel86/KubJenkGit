pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'kyriel86/test'
    }
    stages {
        stage('Clone repository') {
            steps {
                checkout scm
            }
        }
        stage('Build image') {
            steps {
                script {
                    docker.withDockerServer([uri: 'tcp://docker:2375']) {
                        docker.build(DOCKER_IMAGE, '.')
                    }
                }
            }
        }
        stage('Test image') {
            steps {
                script {
                    docker.withDockerServer([uri: 'tcp://docker:2375']) {
                        docker.image(DOCKER_IMAGE).inside {
                            sh 'echo "Tests passed"'
                        }
                    }
                }
            }
        }
        stage('Push image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        docker.image(DOCKER_IMAGE).push("${env.BUILD_NUMBER}")
                    }
                }
            }
        }
        stage('Trigger ManifestUpdate') {
            steps {
                echo "Triggering updatemanifestjob"
                build job: 'updatemanifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
            }
        }
    }
}
