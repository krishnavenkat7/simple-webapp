def getTimeStamp(){
    return sh (script: "date +'%Y%m%d%H%M%S%N' | sed 's/[0-9][0-9][0-9][0-9][0-9][0-9]\$//g'", returnStdout: true);
}
def getEnvVar(String paramName){
    // return sh (script: "grep '${paramName}' env_vars/project.properties|cut -d'=' -f2", returnStdout: true).trim();
}
def getTargetEnv(String branchName){
    def deploy_env = 'none';
    switch(branchName) {
        case 'master':
            deploy_env='uat'
        break
        case 'develop':
            deploy_env = 'dev'
        default:
            if(branchName.startsWith('release')){
                deploy_env='sit'
            }
            if(branchName.startsWith('feature')){
                deploy_env='none'
            }
    }
    return deploy_env
}

def getImageTag(String currentBranch)
{
    def image_tag = 'latest'
    if(currentBranch==null){
        image_tag = getEnvVar('IMAGE_TAG')
    }
    if(currentBranch=='master'){
        image_tag= getEnvVar('IMAGE_TAG')
    }
    if(currentBranch.startsWith('release')){
        image_tag = currentBranch.substring(8);
    }
    return image_tag
}
pipeline {
    agent any
    environment {
    registry = "venkatnamburi/webapp"
    registryCredential = 'docker_login'
    GIT_COMMIT_SHORT_HASH = sh (script: "git rev-parse --short HEAD", returnStdout: true)
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
        stage('Cleanup'){
        steps{
            sh '''
            docker rmi $(docker images -f 'dangling=true' -q) || true
            docker rmi $(docker images | sed 1,2d | awk '{print $3}') || true
            '''
           }
        }
        stage('BUildImage') {
             steps {
                 echo 'Starting to build docker image'
                 script {
                    // app = docker.build("webapp:${env.BUILD_ID}")
                     app = docker.build("$registry:stable-${env.BUILD_ID}")
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
                  // sshCommand command: "ls -lrt"
                 sh ' ansible all -m shell -a 'minikube version && df -hm && free -m' '
             }
         }
    }
}
