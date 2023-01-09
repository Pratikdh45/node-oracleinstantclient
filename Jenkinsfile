pipeline {
    agent any          
    stages{
        stage('Init'){
            steps {
            script {
                env.VERSION = readFile(file: 'version.txt')
                echo "Build Version = $VERSION"
		currentBuild.displayName = "${params.SERVICE_NAME}-${env.VERSION}"
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
        stage('Deploy'){
            steps {
            script{
	    sh """#!/bin/bash
            cat deployment.yaml | grep VERSION
            sed -i 's|VERSION: .*|VERSION: ${VERSION}|' deployment.yml
            cat deployment.yaml | grep VERSION
            """
	    }
	    }
        }
    }
}
