FROM centos:7

MAINTAINER Derek DeJonghe "mittendevelopment@gmail.com"

ENV VER_AWS="1.7.1"
ENV VER_HTTP="0.11"
ENV VER_LUA="5.1"
ENV VER_LUAROCKS="2.4.0"
ENV VER_RESTY="1.11.2.1"

RUN yum install -y \
    readline-devel \
    pcre-devel \
    openssl-devel \
    openssl \
    libffi \
    gcc \
    make \
    perl \
    'perl(ExtUtils::Embed)' \
    wget \
    lua-devel \
    unzip \
    git


RUN cd /tmp && \
    wget https://openresty.org/download/openresty-${VER_RESTY}.tar.gz && \
    tar xvf openresty-${VER_RESTY}.tar.gz && \
    cd openresty-${VER_RESTY} && \
    ./configure && \
    ./configure \
        --with-http_perl_module &&\
     make -j 2 && \
    make install -j 2

RUN cd /tmp && \
    wget https://github.com/pintsized/lua-resty-http/archive/v${VER_HTTP}.tar.gz -O lua-resty-http-${VER_HTTP}.tar.gz && \
    tar xvf lua-resty-http-${VER_HTTP}.tar.gz && \
    cd lua-resty-http-${VER_HTTP} && \
    make LUA_LIB_DIR=/usr/local/openresty/lualib/ && \
    make install LUA_LIB_DIR=/usr/local/openresty/lualib/

RUN cd /tmp && \
    wget http://keplerproject.github.io/luarocks/releases/luarocks-2.4.0.tar.gz && \
    tar xvf luarocks-2.4.0.tar.gz && \
    cd luarocks-2.4.0 && \
    ./configure && \
    make build && \
    make install

RUN /usr/local/bin/luarocks install lua-api-gateway-cachemanager
RUN /usr/local/bin/luarocks install lua-api-gateway-hmac

RUN cd /tmp && \
    wget http://github.com/adobe-apiplatform/api-gateway-aws/archive/${VER_AWS}.tar.gz -O api-gateway-aws-${VER_AWS}.tar.gz && \
    tar xvf api-gateway-aws-${VER_AWS}.tar.gz && \
    cd api-gateway-aws-${VER_AWS} && \
    make LUA_LIB_DIR=/usr/local/openresty/lualib/ && \
    make install LUA_LIB_DIR=/usr/local/openresty/lualib/

RUN ln -s /usr/local/openresty/nginx/sbin/nginx /usr/local/bin/nginx

ADD nginx-conf/ /usr/local/openresty/nginx/conf 

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

