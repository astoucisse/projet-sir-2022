pipeline{
    agent any
    tools{
        maven '3.6.3'
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
                        sh 'docker build . -t  projet-sir:1'
                    }
               }
        stage ('DockerHub Push') {
                steps{
                  withCredentials([string(credentialsId:'docker-hub',variable:'astou0603')])
                          sh 'docker login -u astoucisse -p ${astou0603}'
                          sh 'docker push  projet-sir:1'
                         }
                  }
      /*  stage ('Deploy to kubernetes') {
                 steps{
                        sh 'chmod +x changeTag.sh'
                        sh './changeTag.sh'
                     }
                  }
*/

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