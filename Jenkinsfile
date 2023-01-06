pipeline {
    agent any      
    stages{
        stage('Build Version'){
            steps {
            script {
                VERSION = readFile(file: 'version.txt')
                println(VERSION)
                sh "export VERSION=$VERSION"
                echo $VERSION
               }
            }
        }        
    }
}
