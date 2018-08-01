# docker-private-registry-with-ui

## Introduction

This repo have a Script that can be used to deploy a docker private registry with an UI interface. It use the official repository [docker registry](https://hub.docker.com/_/registry/) and the public [Joxit/docker-registry-ui](https://hub.docker.com/r/joxit/docker-registry-ui/). 

This script have been tested in ubuntu 16.04+ and you must check that you have docker installed in your system before use it.

## HOW DOES IT WORKS?

1. You have to run the script.sh and then you need to enter the followed info:
```
read -p 'registry domain: ' domain
read -p 'registry email: ' email
read -p 'registry port: ' port
read -p 'ui registry port: ' uiport
read -p 'Username: ' username
read -sp 'Password: ' password
```

2. The script download the appropiated certbot-auto and run certbot to obtain the certificates with the registry domain and email entered above.
```
sudo git clone https://github.com/certbot/certbot   
cd certbot    
sudo ./certbot-auto certonly -n --standalone --agree-tos --email $email -d $domain   
```
3. The script make a copy of the certificates obtain with certbot and rename it to **domain.crt** and **domain.key** to be 
used for the docker registry.
```
cd /etc/letsencrypt/live/$domain/   
cp privkey.pem domain.key  
cat cert.pem chain.pem > domain.crt   
chmod 777 domain.crt   
chmod 777 domain.key   
```
4. The script create an username -> password encrypted file for docker registry located in /etc/docker-registry/.htpasswd
5. The script run the docker o
