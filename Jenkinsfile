pipeline {
    agent any

    stages {
        

        stage ('Dockerize') {

            steps {
                sh '''
                    rm -rf *
                    git clone https://github.com/uhsder/test
                    cd test
                    sudo bash dockerInstall.sh
                    sudo docker build nginxlua .
                '''
                }
            
        }
    }
}