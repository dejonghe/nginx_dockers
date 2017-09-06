FROM centos:7

MAINTAINER Derek DeJonghe "mittendevelopment@gmail.com"

RUN yum -y install epel-release && \
    yum -y install nginx nginx-mod-http-perl
    

ADD /nginx-conf /etc/nginx

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
