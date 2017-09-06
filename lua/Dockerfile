FROM centos:7

MAINTAINER Derek DeJonghe "mittendevelopment@gmail.com"

ENV VER_NGINX_DEVEL_KIT=0.3.0
ENV VER_LUA_NGINX_MODULE=0.10.10
ENV VER_NGINX=1.13.5
ENV VER_LUAJIT=2.0.5
ENV VER_PCRE=8.39
ENV VER_ZLIB=1.2.11
ENV VER_SSL=1.0.2l


ENV NGINX_DEVEL_KIT ngx_devel_kit-${VER_NGINX_DEVEL_KIT}
ENV LUA_NGINX_MODULE lua-nginx-module-${VER_LUA_NGINX_MODULE}
ENV NGINX_ROOT=/nginx
ENV WEB_DIR ${NGINX_ROOT}/html

ENV LUAJIT_LIB /usr/local/lib
ENV LUAJIT_INC /usr/local/include/luajit-2.0


RUN yum -y update && \
    yum -y install gcc \
    gcc-c++ \
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
RUN cd /opt && \
    wget http://www.openssl.org/source/openssl-${VER_SSL}.tar.gz && \
    tar -zxf openssl-${VER_SSL}.tar.gz && \
    cd openssl-${VER_SSL} && \
    ./config && \
    make && \
    make install && \
    rm ../openssl-${VER_SSL}.tar.gz

# Install Lua JIT
RUN cd /opt && \
    wget http://luajit.org/download/LuaJIT-${VER_LUAJIT}.tar.gz && \
    tar -zxf LuaJIT-${VER_LUAJIT}.tar.gz && \
    cd LuaJIT-${VER_LUAJIT} && \
    make && \
    make install && \
    rm ../LuaJIT-${VER_LUAJIT}.tar.gz

# Install Lua NGINX Module
RUN cd /opt && \
    wget https://github.com/openresty/lua-nginx-module/archive/v${VER_LUA_NGINX_MODULE}.tar.gz -O ${LUA_NGINX_MODULE}.tar.gz && \
    tar -xzvf ${LUA_NGINX_MODULE}.tar.gz && \
    rm ${LUA_NGINX_MODULE}.tar.gz
RUN cd /opt && pwd && ls -lah && ls -lah ${LUA_NGINX_MODULE}

# Install NGINX Devel Kit
RUN cd /opt && \
    wget https://github.com/simpl/ngx_devel_kit/archive/v${VER_NGINX_DEVEL_KIT}.tar.gz -O ${NGINX_DEVEL_KIT}.tar.gz && \
    tar -xzvf ${NGINX_DEVEL_KIT}.tar.gz && \
    rm ${NGINX_DEVEL_KIT}.tar.gz


# Install NGINX
RUN cd /opt && \
    wget http://nginx.org/download/nginx-${VER_NGINX}.tar.gz && \
    tar zxf nginx-${VER_NGINX}.tar.gz && \
    cd nginx-${VER_NGINX} && \
    ./configure \
        --sbin-path=/usr/local/nginx/nginx \ 
        --conf-path=/etc/nginx/nginx.conf \ 
        --pid-path=/usr/local/nginx/nginx.pid \ 
        --with-ld-opt="-Wl,-rpath,${LUAJIT_LIB}" \
        --with-pcre=/opt/pcre-${VER_PCRE} \ 
        --with-zlib=/opt/zlib-${VER_ZLIB} \ 
        --with-http_ssl_module \ 
        --with-openssl=/opt/openssl-${VER_SSL} \
        --add-module=/opt/${NGINX_DEVEL_KIT} \
        --add-module=/opt/${LUA_NGINX_MODULE} \
    && \
    make && \
    make install && \
    ln -s /usr/local/nginx/nginx /usr/bin/nginx && \
    rm ../nginx-${VER_NGINX}.tar.gz

RUN rm -rf /opt/nginx-${VER_NGINX}
RUN rm -rf /LuaJIT-${VER_LUAJIT}
RUN rm -rf /opt/${NGINX_DEVEL_KIT}
RUN rm -rf /opt/${LUA_NGINX_MODULE}


ADD /nginx-conf /etc/nginx
RUN mkdir -p /var/www/ && \ 
    mkdir -p /var/log/nginx

ADD /index.html /var/www/
ADD /index.html /var/www/resources/

RUN chmod 666 /var/www/index.html 


EXPOSE 80
CMD ["nginx", "-g", "daemon off;" ]
