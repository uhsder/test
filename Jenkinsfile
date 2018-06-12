pipeline {
    agent any

    stages {
        stage ('Build1') {

            steps {
                sh '''
                    git clone https://github.com/uhsder/test
                    cd test
                    chmod 755 nginx.sh
                    ls
                    nginx.sh
                '''
            }
        }
    }
}