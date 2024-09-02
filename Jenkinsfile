#!/usr/bin/env groovy

def NESTED_VOLUME_PATH = ''

pipeline {
    agent any

    stages {
        stage('Set Nested Volume Path') {
            steps {
                script {
                    def nestedVolumePath = sh(
                        script: "docker volume inspect --format '{{ .Mountpoint }}' jenkins_home",
                        returnStdout: true
                    ).trim()

                    def currentWorkspacePath = env.WORKSPACE

                    def homeDir = env.HOME

                    NESTED_VOLUME_PATH = currentWorkspacePath.replace(homeDir, nestedVolumePath)

                    echo "Nested Volume Path: ${NESTED_VOLUME_PATH}"
                }
            }
        }

        stage('Stop and remove previous docker container') {
            steps {
                sh 'docker compose down --remove-orphans'
            }
        }
        stage('Run new docker container') {
            steps {
                echo "Using Nested Volume Path: ${NESTED_VOLUME_PATH}"
                sh 'NESTED_VOLUME_PATH=' + NESTED_VOLUME_PATH + ' EMAIL=${EMAIL} docker compose up -d'
            }
        }
    }
}
