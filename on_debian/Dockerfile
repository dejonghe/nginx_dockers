FROM debian


RUN apt-get update

RUN apt-get install -y wget gnupg libssl1.1 &&\
    wget http://nginx.org/keys/nginx_signing.key 

COPY nginx.list /etc/apt/sources.list.d/nginx.list

RUN apt-key add nginx_signing.key &&\
    apt-get update &&\
    apt-get install -y nginx

COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
