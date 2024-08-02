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
        AWS_ACCESS_KEY_ID="ASIAQEOGYEGLZSGNG5OL"
        AWS_SECRET_ACCESS_KEY="pjVV+YCMmWmMaJhb/NKJiXX/yi9YSgJqEQ3DzI8n"
        AWS_SESSION_TOKEN="IQoJb3JpZ2luX2VjEKP//////////wEaCWV1LXdlc3QtMiJHMEUCIQDZFpgkINK9WF0WOeT5mwycO4yS1/pCd8PF9X76zoDAhwIgdtEvKpgqJlVcwvj6DOW7lcYDpdtjGoom9QOYYFGqnHEqsgMIjP//////////ARACGgwwMDk1NDM2MjMwNjMiDLH9VuWzxh3cDxW7dSqGA2Pwy3SPJ1fD1WYoxl0PD6SM3HNJ3d0UnfUDbgrPHZhdDuj72KI+oUEbY0WS1iIh/UqgKF4jgJrda4jKQm+LTjw+W9W0sbkWSVkvn2sm+tpC7NXNiiZYxFl7dEr7e158EjGIp7wpG8JrmoTaotbt2Pa1OHOKNowwM90UhLTQswrxAARV3TetQNRA26s4Yc5FRH6ZzHhPbRS/pWLiBh9IRPNglVJ12iC5KfEGKb+jaKNQ0DrmXJKTqCzTchUhjar1QUakUTvupEcp4r1b13vQ+zQtyMaUWHzZu5R/1zHY4CO/4O/ahUumfQRlSYe51BNxhGm0/Z29ofId4NC5hP1QFLdcImPPjTZ37CzZ1yTfJoTqvhLfGHbt5vxlLdYRHbh0LB04OJ6B+qObSmsfe7vKfkMZZCrcqcOl/fZMYLGtLGqa0cOLkImGyqn4RoptiR8vCQje+7+C/rD7q2mmXUpQZWs6MK/6CqmqgDMNfNNKkItvddufx6RZtOQ/8+nscSgEAEZ2hNqopjCx+LK1BjqmAfiLg/OB7xwCV081+AyPLIRkcV8olyq9lTPlek/tOUw3XvNqZoHqt5UIfs/RccHmslSko6dI1hbPRzbbmSw52NyTJONm+hmXxVbJs+pTYLHbEeFC1tc7NM14sa1izdFc6a93ZOidqqBuWRn1rmzF27ZMtvUgJFK4APFzcES8Sqw34Ra3AH1bnzprmaQLbQr35UAqIfdjgA2/kzLUk6+juJNV0Om53go="
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
        stage('Prepare Workspace') {
                steps {
                    script {
                        sh "mkdir -p ${env.DOCKER_CONFIG}"
                        sh "aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 009543623063.dkr.ecr.eu-west-2.amazonaws.com"
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
