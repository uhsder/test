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
                    sudo docker build -t nginxlua .
                    export DOCKER_ID_USER=redshu
                    sudo docker login --username=redshu --password=opsworks
                    imageid=$(sudo docker image ls | grep nginxlua | awk '{ print $3 }')
                    sudo docker tag $imageid redshu/opsworks:nginxluaimg
                    sudo docker push redshu/opsworks
                '''
                }
        }
    }
}