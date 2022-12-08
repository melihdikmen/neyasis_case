def appname = "Runner" //DON'T CHANGE THIS. This refers to the flutter 'Runner' target.
def xcarchive = "${appname}.xcarchive"

pipeline {
    stages {
        stage ('Checkout') {
            steps {
                step([$class: 'WsCleanup'])
                checkout scm
                sh "rm -rf brbuild_ios" //This removes the previous checkout of brbuild_ios if it exists.
            }
        }
        stage ('Flutter Doctor') {
            steps {
                sh "flutter doctor -v"
            }
        }
        stage ('Flutter Build APK') {
            steps {
                sh "flutter build apk --flavor neyasisTest -t lib/main.test.dart"
            }
        }
       
        stage('Flutter Build iOS') {
            steps {
                sh "flutter build ios  --flavor neyasisTest -t lib/main.test.dart --release --no-codesign"
               

            }
        }
        stage('Cleanup') {
            steps {
                sh "flutter clean"
            }
        }
    }
}
