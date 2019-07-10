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
             }
         }
    }
}
