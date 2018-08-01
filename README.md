# docker-private-registry-with-ui

#@ Introduction

The Docker Registry HTTP API is the protocol to facilitate distribution of images to the docker engine. It interacts with instances of the docker registry, which is a service to manage information about docker images and enable their distribution. The specification covers the operation of version 2 of this API, known as Docker Registry HTTP API V2.
While the V1 registry protocol is usable, there are several problems with the architecture that have led to this new version. The main driver of this specification is a set of changes to the Docker image format, covered in docker/docker#8093. The new, self-contained image manifest simplifies image definition and improves security. This specification will build on that work, leveraging new properties of the manifest format to improve performance, reduce bandwidth usage and decrease the likelihood of backend corruption.

For relevant details and history leading up to this specification, please see the following issues:
