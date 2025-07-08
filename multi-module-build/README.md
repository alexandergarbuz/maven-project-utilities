# Multi Module Build Project 

This project is an example of how a multi module build can be set up.

## Project Overview

This is a basic example of a multi module build project using Maven.

Core components are:

* [`Core`](./multi-module-build-core/) - Core shared libraries
* [`Web`](./multi-module-build-web/) - SpringBoot bases Web UI 
* [`Services`](./multi-module-build-services/) - SpringBoot microservices (API)



## Maven Site

Everytime you push the code change to the `multi-module-build` project it will automatically trigger a new build and deploy a new version of the Maven site.

One the build is finished it will be available at this location [https://alexandergarbuz.github.io/maven-project-utilities/](https://alexandergarbuz.github.io/maven-project-utilities/).
