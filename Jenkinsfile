pipeline {
    agent any
    tools {
        maven 'M3'
    }
    stages {
        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }
         stage('artifact') {
             steps {
               archiveArtifacts artifacts: 'target/*.war', onlyIfSuccessful: true
             }
         }
         stage ('deploy') {
             steps {
                 echo ''
                 bat '''copy **/*.war C:/apache-tomcat-8.5.42-windows-x64/apache-tomcat-8.5.42/webapps'''
             }
         }
    }
}
