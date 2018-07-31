#!/usr/bin/env bash
# Bash Menu Script Example

if (( $EUID != 0 )); then
  echo "You need to be root to execute this script"
  exit
fi

read -p 'registry domain: ' domain
read -p 'registry port: ' port
read -p 'ui registry port: ' uiport
read -p 'email: ' email
read -p 'Username: ' username
read -sp 'Password: ' password
echo

if [ "$domain" = "" ]; then
  echo "missing registry domain" 1>&2
  exit
fi

if [ "$port" = "" ]; then
  echo "missing registry port" 1>&2
  exit
fi

if [ "$email" = "" ]; then
  echo "missing email" 1>&2
  exit
fi

if [ "$username" = "" ]; then
  echo "missing username" 1>&2
  exit
fi

if [ "$password" = "" ]; then
  echo "missing password" 1>&2
  exit
fi


sudo git clone https://github.com/certbot/certbot
cd certbot 
sudo ./certbot-auto certonly -n --standalone --agree-tos --email $email -d $domain

cd /etc/letsencrypt/live/$domain/
cp privkey.pem domain.key
cat cert.pem chain.pem > domain.crt
chmod 777 domain.crt
chmod 777 domain.key

mkdir /etc/docker-registry
docker run --entrypoint htpasswd registry:2 -Bbn $username $password > /etc/docker-registry/.htpasswd

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

docker run -d -p $uiport:80 -e REGISTRY_URL=https://$domain:$port -e DELETE_IMAGES=true -e REGISTRY_TITLE="My registry" joxit/docker-registry-ui:static



