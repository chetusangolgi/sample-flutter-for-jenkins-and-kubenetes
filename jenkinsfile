pipeline {
  agent any

  environment {
    IMAGE_NAME = 'flutter-web-temp'
    PORT = '8085'
  }

  stages {
    stage('Clone Code') {
      steps {
        git branch: 'main', url: 'https://github.com/chetusangolgi/sample-flutter-for-jenkins-and-kubenetes.git'
      }
    }

    stage('Flutter Build') {
      steps {
        sh 'flutter pub get'
        sh 'flutter build web'
      }
    }

    stage('Docker Build') {
      steps {
        sh "docker build -t $IMAGE_NAME ."
      }
    }

    stage('Run Docker Container') {
      steps {
        sh "docker run -d --rm -p $PORT:80 --name flutter_web_instance $IMAGE_NAME"
      }
    }

    stage('Success Info') {
      steps {
        echo "🎉 App is running at http://localhost:$PORT"
      }
    }
  }
}
