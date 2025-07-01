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

    stage('Debug: Check Flutter & Git') {
      steps {
        bat 'echo PATH: %PATH%'
        bat 'flutter --version'
        bat 'git --version'
      }
    }

    stage('Flutter Build') {
      steps {
        // Fix the ownership issue for Git safe.directory
        bat 'git config --global --add safe.directory C:/flutter'

        // Run Flutter commands
        bat 'flutter pub get'
        bat 'flutter build web'
      }
    }

    stage('Docker Build') {
      steps {
        bat "docker build -t %IMAGE_NAME% ."
      }
    }

    stage('Run Docker Container') {
      steps {
        bat "docker run -d --rm -p %PORT%:80 --name flutter_web_instance %IMAGE_NAME%"
      }
    }

    stage('Success Info') {
      steps {
        echo "✅ Flutter Web App is now running at: http://localhost:%PORT%"
        echo "🕒 Note: Container is set to run indefinitely unless stopped manually."
      }
    }
  }
}
