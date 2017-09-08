FROM centos:7

MAINTAINER Derek DeJonghe "mittendevelopment@gmail.com"

# NGINX Unit stuff
ADD unit.repo /etc/yum.repos.d/unit.repo

RUN yum -y install unit

# Flask example stuff
RUN yum install -y epel-release
RUN yum install -y python-pip

RUN pip install flask

RUN mkdir /var/app

ADD python-app/ /var/app/



EXPOSE 8080 8081

CMD ["unitd", "--no-daemon", "--control", "*:8080"]
