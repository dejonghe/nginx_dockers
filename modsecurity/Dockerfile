FROM centos:7

MAINTAINER Derek DeJonghe "mittendevelopment@gmail.com"

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
#RUN cd opt && \
    ##wget http://www.openssl.org/source/openssl-1.0.2j.tar.gz && \
    #tar -zxf openssl-1.0.2j.tar.gz && \
    #cd openssl-1.0.2j && \
    #./config && \
    #make && \
    #make install 

RUN cd opt && \
    wget https://www.modsecurity.org/tarball/2.9.1/modsecurity-2.9.1.tar.gz && \
    tar -zxf modsecurity-2.9.1.tar.gz && \
    cd modsecurity-2.9.1 && \
    ./configure --enable-standalone-module && \
    make 

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
        --with-http_secure_link_module \
        --add-module=../modsecurity-2.9.1/nginx/modsecurity \ 
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

CMD ["nginx", "-g", "daemon off;"
