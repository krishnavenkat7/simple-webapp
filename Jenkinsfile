pipeline {
    agent any
    environment {
    registry = "venkatnamburi/webapp"
    registryCredential = 'docker_login'
    }
    tools {
        maven 'M3'
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
         stage('Archiveartifact') {
             steps {
               archiveArtifacts artifacts: 'target/*.war', onlyIfSuccessful: true
             }
         }
        stage('BUildImage') {
             steps {
                 echo 'Starting to build docker image'
                 script {
                    // app = docker.build("webapp:${env.BUILD_ID}")
                     app = docker.build("$registry:${env.BUILD_ID}")
                     // app.push()
                 }
             }
         }
        stage('Push Image 2 Hub') {
             steps {
                 echo 'Starting to push the docker image'
                 script {
                     docker.withRegistry('', registryCredential ) {
                     app.push() 
                     }
                 }
             }
         }
         stage ('deploy') {
             steps {
                 echo ''
                 // bat '''copy target\\*.war C:\\apache-tomcat-8.5.42-windows-x64\\apache-tomcat-8.5.42\\webapps\\'''
                 //sh 'ssh ec2-user@ && sudo -i && helm upgrade first ./firstrepo && kubectl get all -o wide'
                  sshCommand command: "ls -lrt"
                 
             }
         }
    }
}
