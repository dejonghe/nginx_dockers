FROM centos:7

MAINTAINER Derek DeJonghe "mittendevelopment@gmail.com"

ENV VER_NGINX=1.13.5
ENV VER_PCRE=8.39
ENV VER_ZLIB=1.2.11
ENV VER_SSL=1.0.2l

RUN yum -y update && \
    yum -y install gcc \
    gcc-c++ \
    make \
    openssl \
    openssl-devel \
    perl \
    'perl(ExtUtils::Embed)' \
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
RUN cd /opt && \
    wget http://www.openssl.org/source/openssl-${VER_SSL}.tar.gz && \
    tar -zxf openssl-${VER_SSL}.tar.gz && \
    cd openssl-${VER_SSL} && \
    ./config && \
    make && \
    make install && \
    rm ../openssl-${VER_SSL}.tar.gz


# Install NGINX
RUN cd opt && \
    wget http://nginx.org/download/nginx-1.11.4.tar.gz && \
    tar zxf nginx-1.11.4.tar.gz && \
    cd nginx-1.11.4 && \
    ./configure \
        --sbin-path=/usr/local/nginx/nginx \ 
        --conf-path=/etc/nginx/nginx.conf \ 
        --pid-path=/usr/local/nginx/nginx.pid \ 
        --with-pcre=../pcre-8.39 \ 
        --with-zlib=../zlib-1.2.8 \ 
        --with-http_ssl_module \ 
        --with-stream \ 
        --with-http_ssl_module \
        --with-http_perl_module \
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
