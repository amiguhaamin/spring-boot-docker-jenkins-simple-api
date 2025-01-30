pipeline {
    agent any
//     tools {
//         maven 'M3'
//     }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('rashmikguhaamin_dockerhub')
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', credentialsId: 'DOCKERHUB_CREDENTIALS', url: 'https://github.com/amiguhaamin/spring-boot-docker-jenkins-simple-api.git'
            }
        }
        stage('Compile and Clean') {
            steps {
                withMaven(maven: 'mvn') {

                    // Run Maven on a Unix agent.
                    sh "mvn clean compile"
                }
            }
        }
        stage('deploy') {
steps {
            withMaven(maven: 'mvn') {
                sh "mvn package"
            }
            }
        }
        stage('Build Docker image'){

            steps {
                echo "Binding docker image for spring-boot-starter-parent.."
                sh 'ls'
                sh 'docker build -t  rashmikguhaamin/docker_jenkins_springboot:${BUILD_NUMBER} .'
            }
        }
        stage('Docker Login'){

            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
            /* steps {
                    withCredentials([string(credentialsId: 'DockerId', variable: 'Dockerpwd')]) {
                    sh "docker login -u rashmikguhaamin -p ${Dockerpwd}"
                }
            } */
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
    post {
        always {
            sh 'docker logout'
        }
    }
}