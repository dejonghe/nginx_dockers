FROM 356438515751.dkr.ecr.us-east-1.amazonaws.com/centos:master

MAINTAINER Derek DeJonghe "mittendevelopment@gmail.com"

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
RUN cd opt && \
    wget http://ftp.exim.org/pub/pcre/pcre-8.39.tar.gz && \
    tar -zxf pcre-8.39.tar.gz && \
    cd pcre-8.39 && \
    ./configure && \
    make && \
    make install
    
# Install zlib
RUN cd opt && \
    wget http://zlib.net/zlib-1.2.8.tar.gz && \
    tar -zxf zlib-1.2.8.tar.gz && \
    cd zlib-1.2.8 && \
    ./configure && \
    make && \
    make install

# Install openSSL 
RUN cd opt && \
    wget http://www.openssl.org/source/openssl-1.0.2f.tar.gz && \
    tar -zxf openssl-1.0.2f.tar.gz && \
    cd openssl-1.0.2f && \
    ./config && \
    make && \
    make install 

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
CMD ["nginx"]
