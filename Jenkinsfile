pipeline {
    agent any

    stages {
        stage ('Build1') {

            steps {
                bash '''#!/bin/bash
                 git clone https://github.com/uhsder/test
                 cd test
                 bash -x nginx.sh
                '''
            }
        }

        stage ('Dockerize') {

            steps {
                bash '''#!/bin/bash
                 git clone https://github.com/uhsder/test
                 cd test
                 bash dockerInstall.sh
                 docker build nginxlua .
                '''
                }
            
        }
    }
}