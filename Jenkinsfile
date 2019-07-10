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

               archiveArtifacts artifacts: 'target/*.war', onlyIfSuccessful: true
             }
         stage ('deploy'){
         
         
        }  
    }
}
