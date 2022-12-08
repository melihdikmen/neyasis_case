def appname = "Runner" //DON'T CHANGE THIS. This refers to the flutter 'Runner' target.
def xcarchive = "${appname}.xcarchive"

pipeline {
    agent any //Change this to whatever your flutter jenkins nodes are labeled.
    environment {
        DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer/"  //This is necessary for Fastlane to access iOS Build things.
    }
    stages {
        stage ('Checkout') {
            steps {
                step([$class: 'WsCleanup'])
                checkout scm
                sh "rm -rf brbuild_ios" //This removes the previous checkout of brbuild_ios if it exists.
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
