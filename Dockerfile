#Pull jenkins from dockerHub
FROM jenkins/jenkins:lts-jdk11

#Run commands with root user
USER root

#install updates and lsb-release
RUN apt-get update && apt-get install -y lsb-release

#download key
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
    https://download.docker.com/linux/debian/gpg

RUN echo "deb [arch=$(dpkg --print-architecture) \
    signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
    https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

#update and install docker-ce-cli
RUN apt-get update && apt-get install -y docker-ce-cli

#switch user to Jenkins and use for blueocean installation
USER jenkins

#install latest version of blueocean plugin
RUN jenkins-plugin-cli --plugins "blueocean:latest docker-workflow:1.28"