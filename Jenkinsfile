pipeline {
    agent any
    environment {
        DOCKER_CONFIG = "${env.WORKSPACE}/.docker"
        DOCKER_REGISTRY = '009543623063.dkr.ecr.eu-west-2.amazonaws.com'
//         DOCKER_IMAGE_NAME = "${env.JOB_NAME.split('/')[-2]?.replaceFirst('docker-', '')}"
        DOCKER_IMAGE_NAME="docker-aws-xray-test"
        DOCKER_TAG = "${env.BRANCH_NAME == 'master' ? 'latest' : env.BRANCH_NAME}"
        DOCKER_OPTS = '--pull --compress --no-cache=true --force-rm=true --progress=plain '
        DOCKER_BUILDKIT = '1'
        AWS_REGION = 'eu-west-2'
        BRANCH_NAME = 'develop'
        ECR_REPO = '009543623063.dkr.ecr.eu-west-2.amazonaws.com/jenkins-gradle-ci'
        AWS_CREDENTIALS_ID = 'aws-jenkins-service-account-credentials' // ID for AWS credentials in Jenkins
    }

    triggers {
        upstream(upstreamProjects: 'Docker/docker-amazonlinux/2')
    }

    options {
        ansiColor('xterm')
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '5'))
        disableConcurrentBuilds()
    }

    stages {
        stage('Authenticate to ECR') {
                    steps {
                        withCredentials([aws(credentialsId: "${AWS_CREDENTIALS_ID}", accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                            script {
                                 def AWS_PASSWORD = sh(script: "aws ecr get-login-password --region ${AWS_REGION}", returnStdout: true).trim()
                                 sh "echo ${AWS_PASSWORD} | docker login --username AWS --password-stdin 009543623063.dkr.ecr.${AWS_REGION}.amazonaws.com"
                            }
                        }
                    }
                }

                    stage('Initialise') {
                        agent {
                            docker {
                                image '009543623063.dkr.ecr.eu-west-2.amazonaws.com/jenkins-docker-ci'
                                alwaysPull true
                                args '-v /var/run/docker.sock:/var/run/docker.sock'
                            }
                        }
                                steps {
                                    script {
                                        def workspaceDir = sh(script: 'pwd', returnStdout: true).trim()
                                        echo "Current working directory: ${workspaceDir}"
                                    }
                                }
                            }
        stage('build') {
            steps {
                sh '''
                    docker build ${DOCKER_OPTS} -t "${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_TAG}" .
                '''
            }
        }

        stage('publish') {
            steps {
                sh '''
                    docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_TAG}
                '''
            }
        }
    }
}
