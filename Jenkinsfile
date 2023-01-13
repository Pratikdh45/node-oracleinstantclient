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
                    sh 'docker login -u pratik1945 -p '
		    sh 'docker push pratik1945/${SERVICE_NAME}:${VERSION}'
            }
        }
        stage('Deploy'){
            steps {
            script{
            sh """
                source /home/builder/.bash_profile
                echo Image Tag is ${env.VERSION}
                cd ${env.SERVICE_NAME}/kubernetes
                sed -i 's/latest/${env.VERSION}/g' deployment.yaml
                cat deployment.yaml
                echo Updating Deployment..
                kubectl apply -f deployment.yaml -n $SERVICE_NAME --force
                sed -i 's/${env.VERSION}/latest/g' deployment.yaml
                """
               }            
            }
        }
    }
}
