ARG ALPINE=3.19
FROM alpine:${ALPINE}
ARG PHP
ARG HOST_USER
COPY rootfs /
RUN apk add --update --no-cache \
        doas \
        git \
        docker-cli \
        php${PHP}-cli \
        php${PHP}-ctype \
        php${PHP}-dom \
        php${PHP}-fileinfo \
        php${PHP}-iconv \
        php${PHP}-mbstring \
        php${PHP}-mysqlnd \
        php${PHP}-openssl \
        php${PHP}-pcntl \
        php${PHP}-pdo \
        php${PHP}-pdo_mysql \
        php${PHP}-phar \
        php${PHP}-posix \
        php${PHP}-simplexml \
        php${PHP}-sodium \
        php${PHP}-sqlite3 \
        php${PHP}-tokenizer \
        php${PHP}-xml \
        php${PHP}-xmlreader \
        php${PHP}-xmlwriter \
        php${PHP}-zip \
        php${PHP}-pecl-mongodb \
        php${PHP}-pecl-pcov \
        php${PHP}-pecl-rdkafka \
        php${PHP}-pecl-redis \
        php${PHP}-pecl-swoole \
        php${PHP}-pecl-xdebug \
    && ln -sf /usr/bin/php${PHP} /usr/bin/php \
    && mv /etc/php/php.ini /etc/php${PHP}/conf.d/zzphp.ini \
    && /usr/local/bin/install-tools \
    && adduser ${HOST_USER} \
    && "${HOST_USER}" | chpasswd \
    && echo "permit ${HOST_USER} as root" > /etc/doas.d/doas.conf \
    && stty -onocr
ENTRYPOINT [ "/usr/bin/php" ]
CMD [ "-v" ]
