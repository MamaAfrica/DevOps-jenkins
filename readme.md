## Jenkins Journey

Learning a CI/CD tool is one of the key requirements of becoming a DevOps Engineer.
This repository contains the basic setup of jenkins with the blueocean plugin, and the simple python app I used to test-run my first jenkins jobs following the tutorial on @DevOps Journey Youtube page.
Please note that this Docker file will pull the latest jenkins and blueocean images.

## YouTube Link

I followed this full 1 hour course on youtube. It was quite helpful. You can check it out:
https://www.youtube.com/watch?v=6YZvp2GwT0A

# Installation

## Build the Jenkins BlueOcean Docker Image.

```
docker build -t myjenkins-blueocean:lts .

#IF you are having problems building the image yourself, you can pull from my registry. `myjenkins-blueocean:lts`

docker pull mamaafrica/myjenkins-blueocean:lts && docker tag mamaafrica/myjenkins-blueocean:lts myjenkins-blueocean:lts
```

## Create the network 'jenkins'

```
docker network create jenkins
```

## Run the Container

### MacOS / Linux

```
docker run --name jenkins-blueocean --restart=on-failure --detach \
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  myjenkins-blueocean:lts
```

### Windows

```
docker run --name jenkins-blueocean --restart=on-failure --detach `
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 `
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 `
  --volume jenkins-data:/var/jenkins_home `
  --volume jenkins-docker-certs:/certs/client:ro `
  --publish 8080:8080 --publish 50000:50000 myjenkins-blueocean:lts
```

## Get the Password

```
docker exec jenkins-blueocean cat /var/jenkins_home/secrets/initialAdminPassword
```

## Connect to the Jenkins

```
https://localhost:8080/
```

## Installation Reference:

https://www.jenkins.io/doc/book/installing/docker/

## alpine/socat container to forward traffic from Jenkins to Docker Desktop on Host Machine

https://stackoverflow.com/questions/47709208/how-to-find-docker-host-uri-to-be-used-in-jenkins-docker-plugin

```
docker run -d --restart=always -p 127.0.0.1:2376:2375 --network jenkins -v /var/run/docker.sock:/var/run/docker.sock alpine/socat tcp-listen:2375,fork,reuseaddr unix-connect:/var/run/docker.sock
docker inspect <container_id> | grep IPAddress
```

## Using my Jenkins Python Agent

```
docker pull mamaafrica/myjenkinsagents:python
```
