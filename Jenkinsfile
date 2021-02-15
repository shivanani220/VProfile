pipeline {
	agent any 
	
    tools { 
        maven 'maven'       
    }
stages { 
     
 stage('git checkout') { 
     steps {
      git 'https://github.com/shivanani220/VProfile.git'
     }
   }

   stage('Build') {
       steps {
          sh label: '', script: 'mvn clean package'
     
       }
   }
 
  stage('Unit Test Results') {
      steps {
      junit '**/target/surefire-reports/TEST-*.xml'
      
     }
 }
stage('sonarqube') {
         environment {
           scannerHome = tool 'sonarqube'
       }
         steps {
            withSonarQubeEnv('sonarqube') {
            sh "${scannerHome}/bin/sonar-scanner"
           }
          timeout(time: 10, unit: 'MINUTES') {
           waitForQualityGate abortPipeline: true
           }
	     }
    }   
    stage('Artifact upload') {
       steps {
       nexusPublisher nexusInstanceId: '1234', nexusRepositoryId: 'maven-releases', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: 'target/vprofile-v1.war']], mavenCoordinate: [artifactId: 'vprofile', groupId: 'com.visualpathit', packaging: 'war', version: '$BUILD_NUMBER']]] 
       
       }
       }
    stage('Deploy War') {
        steps {
          sh label: '', script: 'ansible-playbook deploy.yml'
       } 
   } 
}
post {
     success {
            archiveArtifacts 'target/*.war'
        }
       failure {
           mail to:"shivavamshi.89@gmail.com", subject:"FAILURE: ${currentBuild.fullDisplayName}", body: "Build failed"
        }
   }       
}
