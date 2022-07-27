FROM centos:7

ENV VER_HTTP="0.10.13"
ENV VER_LUA="5.1"


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


ADD nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum -y install nginx



