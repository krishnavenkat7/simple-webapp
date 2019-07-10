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

               archive 'target/*.war'
             }
         stage ('deploy'){
         echo 'deployment started'
         
   }  
    }
}
