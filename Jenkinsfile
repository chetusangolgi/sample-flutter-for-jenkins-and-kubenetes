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
            try {
                # Use the call operator (&) to safely execute the command
                # and capture its output to a variable.
                $flutterOutput = & flutter --version
                Write-Host "Flutter version command executed successfully."
                # Print the captured output
                Write-Host $flutterOutput
            } catch {
                # If an error occurs, print the detailed PowerShell error object
                Write-Host "An error occurred while executing flutter --version:"
                Write-Host $_.Exception.ToString()
                Write-Host "Script stack trace:"
                Write-Host $_.ScriptStackTrace
                exit 1
            }

            Write-Host "==== Checking Git Version ===="
            bat 'git --version'
        '''
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
