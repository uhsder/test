pipeline {
    agent any

    stages {
        stage ('Deploy80') {

            steps {
                sh '''
                    rm -rf *
                    git clone https://github.com/uhsder/test
                    cd test
                    sudo bash dockerInstall.sh
                    base=https://github.com/docker/machine/releases/download/v0.14.0 &&
                    curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
                    sudo install /tmp/docker-machine /usr/local/bin/docker-machine
                    sudo docker-machine create --driver amazonec2 --amazonec2-region eu-west-1 --amazonec2-open-port 80 --amazonec2-access-key $AWS_ACCESS_KEY_ID --amazonec2-secret-key $AWS_SECRET_ACCESS_KEY  aws-sandbox-tfedorenko1
                    sudo docker-machine ssh aws-sandbox-tfedorenko
                    sudo docker pull redshu/opsworks:nginxluaimg
                    imageid=$(sudo docker image ls | grep nginxluaimg | awk '{ print $3 }')
                    sudo docker run --name $imageid -d --restart=always \
                    -p 80:80 $imageid \
                    nginx
                '''
            }
        }
    }
}

