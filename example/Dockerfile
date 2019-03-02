FROM centos:7

MAINTAINER Derek DeJonghe "mittendevelopment@gmail.com"

ADD nginx.repo /etc/yum.repos.d/nginx.repo

RUN yum -y update && \
    yum -y install nginx nginx-mod-http-perl
    

ADD /nginx-conf /etc/nginx

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
