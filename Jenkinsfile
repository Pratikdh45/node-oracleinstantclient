pipeline {
    agent any      
    stages{
        stage('Build Version'){
            steps {
            script {
                VERSION = readFile(file: 'version.txt')
                println(VERSION)
                sh "export VERSION=$VERSION"
               }
            }
        } 
        stage('ECHO'){
            steps{
                echo=$VERSION
            }
        }        
        stage('Build Docker Image'){
            steps{
		    sh 'docker build -t pratik1945/${SERVICE_NAME}:${BUILD_VERSION} .'
            }
        }
        stage('DockerHub Push'){
            steps{
                    sh 'docker login -u pratik1945 -p shreekrupa45'
		    sh 'docker push pratik1945/${SERVICE_NAME}:${BUILD_VERSION}'
            }
        }
    }
}
