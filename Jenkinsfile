pipeline {
 agent { label 'docker' }

 environment {
    IMAGE_NAME    = 'jvalentino2/jenkins-agent-maven'
    MAJOR_VERSION = '1'
    HUB_CRED_ID   = 'dockerhub'
  }

  stages {
    
    stage('Docker Start') {
      steps {
       dockerStart()
      }
    } // Docker Start

     stage('Build') {
      steps {
       build("${env.IMAGE_NAME}")
      }
    } // Build

    stage('Test') {
      steps {
       test()
      }
    } // Test
    
    stage('Publish') {
      steps {
        publish("${env.IMAGE_NAME}", "${env.MAJOR_VERSION}", "${env.HUB_CRED_ID}")
      }
    } // Publish

    stage('Docker Stop') {
      steps {
       dockerStop()
      }
    } // Docker Start

  }
}

def dockerStart() {
  sh '''
    nohup dockerd &
    sleep 10
  '''
}

def dockerStop() {
  sh 'cat /var/run/docker.pid | xargs kill -9 || true'
}

def build(imageName) {
  sh "docker build -t ${imageName} ."
}

def test() {
  sh "./test.sh"
}

def publish(imageName, majorVersion, credId) {
  withCredentials([usernamePassword(
      credentialsId: credId, 
      passwordVariable: 'DOCKER_PASSWORD', 
      usernameVariable: 'DOCKER_USERNAME')]) {
          sh """
              docker login --username $DOCKER_USERNAME --password $DOCKER_PASSWORD
              docker tag ${imageName}:latest ${imageName}:${majorVersion}.${BUILD_NUMBER}
              docker tag ${imageName}:latest ${imageName}:latest
              docker push ${imageName}:${majorVersion}.${BUILD_NUMBER}
              docker push ${imageName}:latest
          """
      }
}