pipeline {
    agent any      
    stages{
        stage('Build Version'){
            steps {
            script {
                def version = readFile(file: 'version.txt')
                println(version)
                echo version
                export VERSION=$1
                echo "version"= $VERSION
               }
            }
        }        
        stage('Build Docker Image'){
            steps{
		    sh 'docker build -t pratik1945/${SERVICE_NAME}:${VERSION} .'
            }
        }
        stage('DockerHub Push'){
            steps{
                    sh 'docker login -u pratik1945 -p shreekrupa45'
		    sh 'docker push pratik1945/${SERVICE_NAME}:${VERSION}'
            }
        }
    }
}
