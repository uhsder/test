pipeline {
    agent any

    stages {
/*       stage ('Build') {
            steps {
                sh '''
                    rm -rf *
                    git clone https://github.com/uhsder/test
                    cd test
                    chmod 755 nginx.sh
                    sudo bash nginx.sh
                '''
            }
        }
*/
        stage ('Dockerize') {
            steps {
                sh '''
                    rm -rf *
                    git clone https://github.com/uhsder/test
                    cd test
                    sudo bash dockerInstall.sh
                    sudo docker build -t nginxlua .
                    export DOCKER_ID_USER=redshu
                    sudo docker login --username=redshu --password=$DOCKER_HUB_PASS
                    imageid=$(sudo docker image ls | grep nginxlua | awk '{ print $3 }')
                    sudo docker tag $imageid redshu/opsworks:nginxluaimg
                    sudo docker push redshu/opsworks
                '''
                }
        }

        stage ('Deploy') {
            steps {
                sh '''
                    rm -rf *
                    git clone https://github.com/uhsder/test
                    cd test
                    sudo bash dockerInstall.sh
                    base=https://github.com/docker/machine/releases/download/v0.14.0 &&
                    curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
                    sudo install /tmp/docker-machine /usr/local/bin/docker-machine
                    sudo docker-machine create --driver amazonec2 --amazonec2-region eu-west-1 --amazonec2-security-group launch-wizard-4 --amazonec2-open-port 80 --amazonec2-access-key $AWS_ACCESS_KEY_ID --amazonec2-secret-key $AWS_SECRET_ACCESS_KEY  aws-sandbox-tfedorenko8
                    sudo docker-machine ssh aws-sandbox-tfedorenko8
                    sudo docker-machine ssh aws-sandbox-tfedorenko8 sudo docker pull redshu/opsworks:nginxluaimg
                    sudo docker-machine ssh aws-sandbox-tfedorenko8 sudo docker run --name nginxluaimg -d --restart=always \
                    -p 80:80 redshu/opsworks:nginxluaimg \
                    nginx
                '''
            }
        }
    }
}

