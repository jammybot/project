!/bin/bash

sudo apt-get update && \
sudo apt-get install docker docker.io -y && \
sudo docker pull jibba/web-dvwa:project && \
sudo docker run -d -it -p 80:80 jibba/web-dvwa:project