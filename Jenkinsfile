pipeline{
    agent any
    tools{
        maven '3.6.3'
    }
    environment{
       DOCKER_TAG=getDockerTag()
    }

    stages{
        stage('Source') {
            steps{
                git branch: 'main', url: 'https://github.com/astoucisse/projet-sir-2022.git'
            }
        }

        stage ('Build') {
            steps{
                sh 'mvn clean org.jacoco:jacoco-maven-plugin:prepare-agent install'
            }
        }
        stage ('SonarQube Analysis') {
            steps{
                sh 'mvn sonar:sonar'
            }
        }
        stage ('Build Docker image') {
                    steps{
                        sh 'docker build . -t  projet-sir:${DOCKER_TAG}'
                    }
               }
        stage ('Dockerhub Push') {
                  steps{
                  withCredentials([string(credentialsId:'docker-hub',variable:'astou0603')])
                          sh 'docker login -u astoucisse -p ${astou0603}'
                          sh 'docker push  projet-sir:${DOCKER_TAG}'
                         }
                  }


       stage ('Approve Deployment') {
            input {
                message 'Do you want to proceed for deployment?'
            }
            steps{
                sh 'echo "Deploying into Server "'
            }
        }

    } // stages

    post {
        aborted {
            echo "Sending message to Astou"
        } // aborted

        failure {
            echo "Sending message to Agent"
        } // failure

        success {
            echo "Sending message to Agent"
        } // success
    } // post

}