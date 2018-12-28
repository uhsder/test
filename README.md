3 stages: 

1. Build. Compile the latest version of Nginx server with a lua-nginx-module.

2. Dockerize. Create a docker image with adding custom nginx.conf and index.html from the repository files. Push docker image to the public Docker registry.

3. Deploy. Deploy Nginx container on EC2 instance using docker-machine.


