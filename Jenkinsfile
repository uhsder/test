pipeline {
    agent any

    stages {
        stage ('Build2') {

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