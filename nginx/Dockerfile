FROM openresty/openresty:xenial

RUN apt-get update \
    && apt-get install -y git gcc make \
    && mkdir /src && cd /src \
    && git config --global url."https://".insteadOf git:// \
    \
    # Install lua-resty-redis
    && git clone https://github.com/openresty/lua-resty-redis.git \
    && cp -r lua-resty-redis/lib/resty/* /usr/local/openresty/lualib/resty/ \
    \
    # Install lua-resty-lock
    && git clone https://github.com/openresty/lua-resty-lock.git \
    && cp -r lua-resty-lock/lib/resty/* /usr/local/openresty/lualib/resty/ \
    \
    # Install resty-redis-cluster
    && git clone https://github.com/steve0511/resty-redis-cluster.git \
    && cd resty-redis-cluster/ \
    && git checkout 8d7b96d002337c38d71859e5f04f76b413aa5c29 \
    && luarocks make \
    \
    # Compile redis slot helper
    && gcc -fPIC -shared -I/usr/local/openresty/luajit \
       -o /usr/local/openresty/luajit/lib/lua/5.1/librestyredisslot.so src/redis_slot.c \
    \
    && cd / && rm -rf /src

COPY lua/servefile.lua /usr/local/openresty/lua/servefile.lua
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

EXPOSE 8080
