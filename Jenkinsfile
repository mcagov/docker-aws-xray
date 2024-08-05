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
        AWS_CREDENTIALS = credentials('aws-credentials-id')
//         AWS_ACCESS_KEY_ID="ASIAQEOGYEGLZSGNG5OL"
//         AWS_SECRET_ACCESS_KEY="pjVV+YCMmWmMaJhb/NKJiXX/yi9YSgJqEQ3DzI8n"
//         AWS_SESSION_TOKEN="IQoJb3JpZ2luX2VjEKP//////////wEaCWV1LXdlc3QtMiJHMEUCIQDZFpgkINK9WF0WOeT5mwycO4yS1/pCd8PF9X76zoDAhwIgdtEvKpgqJlVcwvj6DOW7lcYDpdtjGoom9QOYYFGqnHEqsgMIjP//////////ARACGgwwMDk1NDM2MjMwNjMiDLH9VuWzxh3cDxW7dSqGA2Pwy3SPJ1fD1WYoxl0PD6SM3HNJ3d0UnfUDbgrPHZhdDuj72KI+oUEbY0WS1iIh/UqgKF4jgJrda4jKQm+LTjw+W9W0sbkWSVkvn2sm+tpC7NXNiiZYxFl7dEr7e158EjGIp7wpG8JrmoTaotbt2Pa1OHOKNowwM90UhLTQswrxAARV3TetQNRA26s4Yc5FRH6ZzHhPbRS/pWLiBh9IRPNglVJ12iC5KfEGKb+jaKNQ0DrmXJKTqCzTchUhjar1QUakUTvupEcp4r1b13vQ+zQtyMaUWHzZu5R/1zHY4CO/4O/ahUumfQRlSYe51BNxhGm0/Z29ofId4NC5hP1QFLdcImPPjTZ37CzZ1yTfJoTqvhLfGHbt5vxlLdYRHbh0LB04OJ6B+qObSmsfe7vKfkMZZCrcqcOl/fZMYLGtLGqa0cOLkImGyqn4RoptiR8vCQje+7+C/rD7q2mmXUpQZWs6MK/6CqmqgDMNfNNKkItvddufx6RZtOQ/8+nscSgEAEZ2hNqopjCx+LK1BjqmAfiLg/OB7xwCV081+AyPLIRkcV8olyq9lTPlek/tOUw3XvNqZoHqt5UIfs/RccHmslSko6dI1hbPRzbbmSw52NyTJONm+hmXxVbJs+pTYLHbEeFC1tc7NM14sa1izdFc6a93ZOidqqBuWRn1rmzF27ZMtvUgJFK4APFzcES8Sqw34Ra3AH1bnzprmaQLbQr35UAqIfdjgA2/kzLUk6+juJNV0Om53go="
//         AWS_PASSWORD="eyJwYXlsb2FkIjoiSzlrT3hZTi8rTmVmeXBITkxtL21mcTdwZ25PdlVkdUJLQXFQMGM0VXZ6SWg0VHkrc3UrNDNwYTdzWXl4RklydXZoazBybHJUOWdRdVVwK2dTcnJ4Ukw5dkhtLzF3TTNnMFEvOHpucWFuUkE1SGJxdi8xYnJwb1gxMm1kV05QQktoZURVOEZiVDhZd1REV0d2WldSR1ZQem53aEtBK1lqK0EzcGhoTDRDUVA5bTIvQ0hOck1pWDhLSTZKVTFJSCtwYmc4UzA2cStCZ3poZVB0OUtMWk04MVlQZG1DY05WMWFZUEF3Nlh4c3d5WlJqQTkrOFZWQ3lrcWkwbFhvMGJpMitiQ0QxSWM0U0xSdXV3RHJwd1U5ckhsTC9OK1htZXF0VkRua2c5eC84NmxTcFNNOXdIOVJPUUFZNnRDREZ1Q3NqZmIxZkJuV2Z3Z3VZWWRDOUtFY3BPaUdDam12cUU1MXliQjRlWWFPVDhqdXpkTjl5TnEremgrdEdmVTl6OFlLZ3RUcWkxU3c5S01OVnZXUE9GQkNXMTgxT0lScVYwUFlsMUo0OVVHeStYR09hRUhPM2JSOGRVRjhqK01CWGdWOXA0RWRNb2hVc3JMb2RFQzJ4SUV6ZWNLV2FtajYzZTNDRmJOYU9oYjdJZVhQZVhycmJrYXlTSnVmSXdjb1JmRStSWS9pSGp3Y0h3bDRTWkl2T2RBTTVleXVNb1B6N00wbFJKRzZKUkZVOStZa2cwNmxrTy8rVGtHWWFPYzk1MkN4V0t4Wkl2U1RrWDNzNzlySG8xenV6dk1PN1VBWXVBYzJ1eDFoamk4UXVSdWI4Y3h6dGFqcjIvWUkrMlk2ZmhXQ0J5b2d1R3JLVEV3UFJ5RkJFemxsYzh0WklFbFRrZHk0VjFuVUhlTHAwSnUrQ3JlRW5KY21rUzlEcUFkQ0FFaC8yMUxPeHZ1TU1tSURhM1EzbXZMbFg2VlVERFYrQkNlbW5GMTlIMDh4TnJmSXpZZ09Rd3E0WUp2WThpdUtKM2FwcXhvdVcxbXdwUnc3OEJBTUt5Z0hPZDlqUDNuNndnY3hBOXVPQldnYjd4SGpWekFwU3lDdzkrK0UyTHR2YW1ZYXFZUXluSHFzT3dIcGkxVVRITkI5RDg3QncvVC8ydVp2eDFVckZSZFA3V09kVEtvYVBmait3UnNreEorMXFkLy9Ucmh1M0hMMitPK3V1UGgvWDVSaUNPTTVBTmluZ0RUVDlGT1hqNHFYZUEwcTFtY2R1WUc1MXMrNWJtdFpxT1JyeGh5YkNzaUY4WktNbC9BMzljSDVlSmF1V2pkSmxHVzVabitBZlVSVmduT0VwV0hTYXBaZ292VUl1VTBlYk9UMlloZlRsaDZkaFg2SiIsImRhdGFrZXkiOiJBUUVCQUhoTkR6V1ZuWUd5bEszdFVhbEhBTnBtcm5RemE1dzRXNGNIWU1VODJ0Yk5Jd0FBQUg0d2ZBWUpLb1pJaHZjTkFRY0dvRzh3YlFJQkFEQm9CZ2txaGtpRzl3MEJCd0V3SGdZSllJWklBV1VEQkFFdU1CRUVERGcraUxWNTk2OHFEZnFmM0FJQkVJQTdqQ2g0T2RWQXZQSE0zKzRuQTdwTjBrL04xQ2RXcVcxZWNVN1VzVVlld2YzbURRZ2RyWUtzZlJ1RE5vWmdiZlNQQ0ZiSUgvdzhJcUNNZ3k0PSIsInZlcnNpb24iOiIyIiwidHlwZSI6IkRBVEFfS0VZIiwiZXhwaXJhdGlvbiI6MTcyMjY0MTE4OH0="
//
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
                        sh " docker login --username AWS --password ${AWS_PASSWORD} 009543623063.dkr.ecr.eu-west-2.amazonaws.com"
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
