# docker-private-registry-with-ui

## Introduction

This repo have a Script that can be used to deploy a docker private registry with an UI interface. It use the official repository [docker registry](https://hub.docker.com/_/registry/) and the public [Joxit/docker-registry-ui](https://hub.docker.com/r/joxit/docker-registry-ui/).

The goal of this script is simplify the installations of a docker private register with an UI.

## HOW DOES IT WORKS?

1. You have to run the script.sh and then you need to enter the followed info:

registry domain:  
registry port:  
ui registry port:  
email:  
username:  
password:  

2. The script download the appropiated certbot-auto and initialize letsencript with the information entered above.
3. The script creates the certs files ** domain.crt ** and ** domain.key ** for docker registry based on the registry domain entered.
4. The script create a   
