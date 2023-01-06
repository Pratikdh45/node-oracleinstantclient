pipeline {
    agent any          
    stages{
        stage('Build Version'){
            steps {
            script {
                env.VERSION = readFile(file: 'version.txt')
                println(VERSION)
                sh "export VERSION=$VERSION"
                returnStdout: true
                sh "echo ${env.VERSION}"
               }
            }
        }        
        stage('Build Docker Image'){
            steps{
		    sh 'docker build -t pratik1945/${SERVICE_NAME}:${env.VERSION} .'
            }
        }
        stage('DockerHub Push'){
            steps{
                    sh 'docker login -u pratik1945 -p shreekrupa45'
		    sh 'docker push pratik1945/${SERVICE_NAME}:${env.VERSION}'
            }
        }
    }
}
