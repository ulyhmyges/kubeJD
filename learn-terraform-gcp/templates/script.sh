#!/bin/bash

touch hello2.txt

#############Execute docker install script#############
sudo apt-get update
#
cat > /root/docker-install.sh <<- "SCRIPT"
#!/bin/bash

##################Install docker#################
curl -sSL https://get.docker.com | sh

#################Install Docker Compose##########
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

SCRIPT
#
chmod 700 /root/docker-install.sh
/root/docker-install.sh >> /root/docker-install.log
mv /root/docker-install.sh /root/docker-install.sh.EXECUTED #prevent it from running again

cp /root/docker-install.sh.EXECUTED /home/hanane_temal/
cp /root/docker-install.sh.EXECUTED /home/

cp /root/docker-install.log /home/hanane_temal/
cp /root/docker-install.log /home/


#############Install Docker network#############
#create a network most containers will use
docker network create dockernet >> /root/dockernet.log
docker network ls >> /root/dockernet.log

cp /root/dockernet.log /home/hanane_temal/
cp /root/dockernet.log /home/

#
cat > /root/docker-compose.yml <<- "SCRIPT"

version: '3'
services:
  server:
    image: nginx
    container_name: nginx_gcp
    restart: always
    ports:
      - "8080:80"
    networks:
      - dockernet

networks: #use same network across containers to simplify communication between containers
  dockernet:
    driver: bridge
    name: dockernet
    external: true

SCRIPT
#
# network created previously by 'docker network create dockernet' command
cp /root/docker-compose.yml /home/
cp /root/docker-compose.yml /home/hanane_temal/

#############Bring up docker containers############

sudo usermod -aG docker "hanane_temal"
docker compose -f /home/docker-compose.yml up -d