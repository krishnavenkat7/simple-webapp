pipeline {
    agent any
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
               sh 'docker build -t mywebapp .'
             }
         }
         stage ('deploy') {
             steps {
                 echo ''
                 // bat '''copy target\\*.war C:\\apache-tomcat-8.5.42-windows-x64\\apache-tomcat-8.5.42\\webapps\\'''
             }
         }
    }
}
