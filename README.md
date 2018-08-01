# docker-private-registry-with-ui

## Introduction

This repo have a Script that can be used to deploy a docker private registry with an UI interface. It use the official repository [docker registry](https://hub.docker.com/_/registry/) and the public repository [Joxit/docker-registry-ui](https://hub.docker.com/r/joxit/docker-registry-ui/). 

This script have been tested in ubuntu 16.04+ and before use it you must check that you have docker installed in your system.

## HOW DOES IT WORKS?

1. You have to run the script.sh and enter the information prompted. Each data will be stored in its corresponding variable.
```
'registry domain: ' -> $domain
'registry email: ' -> $email
'registry port: ' -> $port
'ui registry port: ' -> $uiport
'username: ' -> $username
'password: ' -> $password
```

2. The script download the appropiated certbot-auto and run certbot to obtain the certificates using the registry domain and email entered above.
```
sudo git clone https://github.com/certbot/certbot   
cd certbot    
sudo ./certbot-auto certonly -n --standalone --agree-tos --email $email -d $domain   
```
3. The script make a copy of the certificates obtain with certbot, rename  **private key** to **domain.crt** and  concatenates **cert.pem** and **chain.pem** in **domain.key**.
```
cd /etc/letsencrypt/live/$domain/   
cp privkey.pem domain.key  
cat cert.pem chain.pem > domain.crt   
chmod 777 domain.crt   
chmod 777 domain.key   
```
4. The script create an username -> password encrypted file for docker registry located in /etc/docker-registry/.htpasswd

```
docker run --entrypoint htpasswd registry:2 -Bbn $username $password > /etc/docker-registry/.htpasswd
```
5. The script deploy the docker registry with the data obtained above.
```
docker run -d\
  -p $port:5000 \
  --name registry \
  -v /var/lib/registry/data:/var/lib/registry \
  -v /etc/letsencrypt/live/$domain:/etc/certs \
  -v /etc/docker-registry:/etc/security \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/etc/certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=/etc/certs/domain.key \
  -e REGISTRY_AUTH=htpasswd \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/etc/security/.htpasswd \
  -e REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm" \
  -e REGISTRY_STORAGE_DELETE_ENABLED =true \
  --restart always \
  registry:2
```
6. Finally the script deploy the docker registry ui.
```
docker run -d -p $uiport:80 \
 -e REGISTRY_URL=https://$domain:$port \
 -e DELETE_IMAGES=true \
 -e REGISTRY_TITLE="My registry" \
joxit/docker-registry-ui:static
