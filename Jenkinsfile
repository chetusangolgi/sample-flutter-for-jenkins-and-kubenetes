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
        // This block runs commands using PowerShell
        powershell '''
            Write-Host "==== Checking Flutter Version ===="
            try {
                # Execute the flutter command.
                # We pipe the output to Out-Null because we only care about the exit code for now.
                & flutter --version | Out-Null

                # Check the exit code of the last command. A non-zero code means error.
                if ($LASTEXITCODE -ne 0) {
                    # Manually throw an error to trigger the catch block.
                    throw "Flutter command failed with exit code $LASTEXITCODE. The original error likely occurred before this message."
                }

                Write-Host "✅ Flutter command executed successfully."
                # Now run it again to print the version in the log
                flutter --version

            } catch {
                Write-Host "❌ An error occurred while executing flutter --version:"
                Write-Host $_
                exit 1
            }
        '''
        // This block runs a command using Windows Batch
        bat 'echo "==== Checking Git Version ===="'
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
