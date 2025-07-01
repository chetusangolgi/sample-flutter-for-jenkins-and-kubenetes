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
    powershell '''
      Write-Host "==== Checking Flutter Version ===="
      flutter --version
    '''
    bat 'git --version'
  }
}


    stage('Flutter Build') {
      steps {
        bat 'git config --global --add safe.directory C:/flutter'
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
        echo "✅ App is live at: http://localhost:%PORT%"
      }
    }
  }
}
