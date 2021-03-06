pipeline {
    agent any
    triggers {
       pollSCM('*/10 * * * *')
    }
    stages {
        stage('Setup') {
            steps {
                deleteDir()
                shHide( 'git clone --recursive https://${GHTOKEN}@github.com/JuiceIoT/Index.git -b $BRANCH_NAME .' )
                sh 'git checkout $BRANCH_NAME'
                sh 'git pull origin $BRANCH_NAME'
                shHide( 'sh set-wifi-credentials.sh ${WIFI_NAME} ${WIFI_PASSWORD}' )
                sh 'sh init-mock-systemctl.sh'
                sh 'sh init-mock-docker.sh'
                sh 'sh init-mock-setup.sh'
                sh 'sh init-mock-submodule-builds.sh'
            }
        }
        stage('Prepare') {
            when { expression { !shouldSkipBuild() } }
            steps {
                sh 'sh prepare.sh'
            }
        }
        stage('Init') {
            when { expression { !shouldSkipBuild() } }
            steps {
                sh 'sh init-all.sh'
            }
        }
        stage('Set MQTT Credentials') {
            when { expression { !shouldSkipBuild() } }
            steps {
                shHide( 'sh set-mqtt-credentials.sh ${MQTT_HOST} ${MQTT_USERNAME} ${MQTT_PASSWORD}' )
            }
        }
        stage('Build') {
            when { expression { !shouldSkipBuild() } }
            steps {
                sh 'sh build-tests.sh'
            }
        }
        stage('Test') {
            when { expression { !shouldSkipBuild() } }
            steps {
                sh 'sh test.sh'
            }
        }
        stage('Clean') {
            when { expression { !shouldSkipBuild() } }
            steps {
                sh 'sh clean.sh'
            }
        }
        stage('Graduate') {
            when { expression { !shouldSkipBuild() } }
            steps {
                sh 'sh graduate.sh'
            }
        }
        stage('Increment Version') {
            when { expression { !shouldSkipBuild() } }
            steps {
              sh 'sh increment-version.sh'
            }
        }
        stage('Push Version') {
            when { expression { !shouldSkipBuild() } }
            steps {
                sh 'sh push-version.sh'
            }
        }
    }
    post {
        success() {
          emailext (
              subject: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
              body: """<p>SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
                <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>"</p>""",
              recipientProviders: [[$class: 'DevelopersRecipientProvider']]
            )
        }
        failure() {
          sh 'sh rollback.sh'
          emailext (
              subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
              body: """<p>FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
                <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>"</p>""",
              recipientProviders: [[$class: 'DevelopersRecipientProvider']]
            )
        }
    }
}
Boolean shouldSkipBuild() {
    return sh( script: 'sh check-ci-skip.sh', returnStatus: true )
}
def shHide(cmd) {
    sh('#!/bin/sh -e\n' + cmd)
}
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
