FROM centos:7

MAINTAINER Derek DeJonghe "mittendevelopment@gmail.com"

ENV VER_NGINX=1.13.5
ENV VER_PCRE=8.39
ENV VER_ZLIB=1.2.11
ENV VER_SSL=1.0.2l
ENV VER_MODSEC=2.9.2


RUN yum makecache fast && \
    yum -y update && \
    yum -y install automake \
    autoconf \
    curl \
    curl-devel \
    gcc \
    gcc-c++ \
    httpd-devel \
    libxml2 \
    libxml2-devel \
    make \
    openssl \
    openssl-devel \
    perl \
    wget

# Install pcre
RUN cd /opt && \
    wget http://ftp.exim.org/pub/pcre/pcre-${VER_PCRE}.tar.gz && \
    tar -zxf pcre-${VER_PCRE}.tar.gz && \
    cd pcre-${VER_PCRE} && \
    ./configure && \
    make && \
    make install && \
    rm ../pcre-${VER_PCRE}.tar.gz

    
# Install zlib
RUN cd /opt && \
    wget http://zlib.net/zlib-${VER_ZLIB}.tar.gz && \
    tar -zxf zlib-${VER_ZLIB}.tar.gz && \
    cd zlib-${VER_ZLIB} && \
    ./configure && \
    make && \
    make install && \
    rm ../zlib-${VER_ZLIB}.tar.gz

# Install openSSL 
#RUN cd /opt && \
#    wget http://www.openssl.org/source/openssl-${VER_SSL}.tar.gz && \
#    tar -zxf openssl-${VER_SSL}.tar.gz && \
#    cd openssl-${VER_SSL} && \
#    ./config && \
#    make && \
#    make install && \
#    rm ../openssl-${VER_SSL}.tar.gz

RUN cd opt && \
    wget https://www.modsecurity.org/tarball/${VER_MODSEC}/modsecurity-${VER_MODSEC}.tar.gz && \
    tar -zxf modsecurity-${VER_MODSEC}.tar.gz && \
    rm modsecurity-${VER_MODSEC}.tar.gz && \
    cd modsecurity-${VER_MODSEC} && \
    ./configure --enable-standalone-module && \
    make

# Install NGINX
RUN cd opt && \
    wget http://nginx.org/download/nginx-${VER_NGINX}.tar.gz && \
    tar zxf nginx-${VER_NGINX}.tar.gz && \
    rm nginx-${VER_NGINX}.tar.gz && \
    cd nginx-${VER_NGINX} && \
    ./configure \
        --sbin-path=/usr/local/nginx/nginx \ 
        --conf-path=/etc/nginx/nginx.conf \ 
        --pid-path=/usr/local/nginx/nginx.pid \ 
        --with-pcre=../pcre-${VER_PCRE} \ 
        --with-zlib=../zlib-${VER_ZLIB} \ 
        --with-http_ssl_module \ 
        --with-stream \ 
        --with-http_ssl_module \
        --with-http_secure_link_module \
        --add-module=../modsecurity-${VER_MODSEC}/nginx/modsecurity \ 
    && \
    make && \
    make install && \
    ln -s /usr/local/nginx/nginx /usr/bin/nginx


ADD /nginx-conf /etc/nginx
RUN mkdir -p /var/www/ && \ 
    mkdir -p /var/log/nginx

ADD /index.html /var/www/
ADD /index.html /var/www/resources/

RUN chmod 666 /var/www/index.html 


EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
