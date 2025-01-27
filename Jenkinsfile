pipeline {
    agent any
    tools {
        maven "3.8.5"

    }
    stages {
        stage('Compile and Clean') {
            steps {
                // Run Maven on a Unix agent.

                sh "mvn clean compile"
            }
        }
        stage('deploy') {

            steps {
                sh "mvn package"
            }
        }
        stage('Build Docker image'){

            steps {
                echo "Binding docker image for simple api.."
                sh 'ls'
                sh 'docker build -t  anvbhaskar/docker_jenkins_springboot:${BUILD_NUMBER} .'
            }
        }
        stage('Docker Login'){

            steps {
                     withCredentials([string(credentialsId: 'DockerId', variable: 'Dockerpwd')]) {
                    sh "docker login -u rashmikguhaamin -p ${Dockerpwd}"
                }
            }
        }
        stage('Docker Push'){
            steps {
                sh 'docker push rashmikguhaamin/maven-spring-boot-jenkins:${BUILD_NUMBER}'
            }
        }
        stage('Docker deploy'){
            steps {

                sh 'docker run -itd -p  8081:8080 rashmikguhaamin/maven-spring-boot-jenkins:${BUILD_NUMBER}'
            }
        }
        stage('Archving') {
            steps {
                 archiveArtifacts '**/target/*.jar'
            }
        }
    }
}