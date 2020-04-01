pipeline {
    agent any 
    tools { 
        maven 'maven' 
      
    }
stages { 
     
 stage('Preparation') { 
     steps {
// for display purpose

      // Get some code from a GitHub repository

git credentialsId: 'git', url: 'https://github.com/shivanani220/VProfile.git'
      // Get the Maven tool.
     
 // ** NOTE: This 'M3' Maven tool must be configured
 
     // **       in the global configuration.   
     }
   }

   stage('Build') {
       steps {
       // Run the maven build

      //if (isUnix()) {
         sh label: '', script: 'mvn clean package'
      //} 
      //else {
      //   bat(/"${mvnHome}\bin\mvn" -Dmaven.test.failure.ignore clean package/)
       }
//}
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
      //  nexusPublisher nexusInstanceId: '1234', nexusRepositoryId: 'releases', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: 'gameoflife-web/target/gameoflife.war']], mavenCoordinate: [artifactId: 'gameoflife', groupId: 'com.wakaleo.gameoflife', packaging: 'war', version: '$BUILD_NUMBER']]]
        nexusArtifactUploader artifacts: [[artifactId: 'vprofile', classifier: '', file: 'target/vprofile-v1.war', type: 'war']], credentialsId: 'nexus', groupId: 'visual', nexusUrl: '3.15.32.55:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'maven-releases', version: '$BUILD_NUMBER' 
        }
       }
     stage('Deploy War') {
        steps {
          sh label: '', script: 'ansible-playbook deploy.yml'
       }
   }
//}
//post {
  //     success {
  //          archiveArtifacts 'gameoflife-web/target/*.war'
    //    }
      // failure {
        //   mail to:"shivavamshi.89@gmail.com", subject:"FAILURE: ${currentBuild.fullDisplayName}", body: "Build failed"
        //}
   }       
}
