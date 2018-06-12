pipeline {
    agent any

    stages {
        stage ('Build') {

            steps {
                sh "#!/bin/bash \n" + 
                    "git clone https://github.com/uhsder/test" +
                    "cd test" +
                    "chmod 755 nginx.sh"
                    "nginx.sh"
                '''
            }
        }
    }
}