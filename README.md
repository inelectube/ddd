# docker-private-registry-with-ui

## Introduction

This repo have a Script that can be used to deploy a docker private registry with an UI interface. It use the official repository [docker registry](https://hub.docker.com/_/registry/) and [Joxit/docker-registry-ui](https://www.google.com)

that can be used to build, ship and run Docker in different environments.
I AM NOT RESPONSIBLE HOW YOU USE THIS TOOL.BE LEGAL AND NOT STUPID.

This script will make your life easier, and of course faster.

Its not only for noobs.Its for whoever wants to type less and do actually more.

This script  Docker Registry HTTP API is the protocol to facilitate distribution of images to the docker engine. It interacts with instances of the docker registry, which is a service to manage information about docker images and enable their distribution. The specification covers the operation of version 2 of this API, known as Docker Registry HTTP API V2.
While the V1 registry protocol is usable, there are several problems with the architecture that have led to this new version. The main driver of this specification is a set of changes to the Docker image format, covered in docker/docker#8093. The new, self-contained image manifest simplifies image definition and improves security. This specification will build on that work, leveraging new properties of the manifest format to improve performance, reduce bandwidth usage and decrease the likelihood of backend corruption.

For relevant details and history leading up to this specification, please see the following issues:
