FROM centos:7

MAINTAINER Derek DeJonghe "mittendevelopment@gmail.com"

ADD unit.repo /etc/yum.repos.d/unit.repo

RUN yum -y install unit


EXPOSE 80 443

CMD ["unit"]
