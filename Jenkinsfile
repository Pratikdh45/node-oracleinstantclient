pipeline {
    agent any
     environment{
         VERSION = "version"
     }       
    stages{
        stage('Build Version'){
            steps {
            script {
                def version = readFile(file: 'version.txt')
                println(version)
                echo version
               }
            }
        }
    stages{
        stage('Build Docker Image'){
            steps{
		    sh 'docker build -t pratik1945/${SERVICE_NAME}:${BUILD_NUMBER} .'
            }
        }
        stage('DockerHub Push'){
            steps{
                    sh 'docker login -u pratik1945 -p shreekrupa45'
		    sh 'docker push pratik1945/${SERVICE_NAME}:${BUILD_NUMBER}'
            }
        }
        // stage('Deploy to DevServer'){
        //     steps{
        //         sshagent (credentials: ['dev-server']) {
		// 		    script{
		// 			    sh returnStatus: true, script: 'ssh ec2-user@172.31.4.187 docker rm -f nodeapp'
		// 				def runCmd = "docker run -d -p 8080:8080 --name=nodeapp kammana/nodeapp:${DOCKER_TAG}"
		// 				sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.4.187 ${runCmd}"
		// 			}
		// 		}
        //     }
        // }
    }
}

// def getDockerTag(){
//     def tag  = sh script: 'git rev-parse HEAD', returnStdout: true
//     return tag
// }
