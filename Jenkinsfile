pipeline {
    agent any

    stages {
        stage ('Build2') {

            steps {
                sh '''
                    rm -rf *
                    git clone https://github.com/uhsder/test
                    cd test
                    chmod 755 nginx.sh
                    ls
                    sudo bash nginx.sh
                '''
            }
        }
    }
}