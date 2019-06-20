FROM centos:latest

LABEL maintainer="Max Castro <github.com/kaioken>, mctekk <github.com/mctekk>"

ARG PHALCON_VERSION=3.4.3
ARG PHALCON_EXT_PATH=php7/64bits

RUN mkdir /app
WORKDIR /app

ADD . /app

RUN  yum -y install epel-release
RUN  yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN  yum-config-manager --enable remi-php72
RUN  yum -y install initscripts
RUN  yum -y update
RUN  yum -y install git
RUN  yum -y install php php-common.x86_64 php-devel.x86_64  php-fpm.x86_64 php-gd.x86_64 \
                    php-intl.x86_64 php-json.x86_64 php-mbstring.x86_64 php-mysqlnd.x86_64 \
                    php-pdo.x86_64 php-pecl-cassandra.x86_64 php-pecl-igbinary.x86_64 php-pecl-mongodb.x86_64 \
                    php-pecl-swoole4.x86_64 php-pgsql.x86_64 php-process.x86_64 \ 
                    php-xml.x86_64 php-opcache.x86_64 php-pecl-gmagick.x86_64 php-pecl-geoip.x86_64 \
                    php-pecl-memcache.x86_64 php-pecl-memcached.x86_64 php-pecl-mcrypt.x86_64 php-pecl-redis.x86_64 \
                    php-pecl-zip.x86_64 php-phalcon3.x86_64 php-sodium.x86_64 php-wkhtmltox.x86_64 composer.noarch
                    
RUN yum -y install gcc make git 

ENV NVM_VERSION v0.34.0
ENV NODE_VERSION v7.5.0
ENV NVM_DIR /usr/local/nvm
RUN mkdir $NVM_DIR
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN echo "source $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default" | bash

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/mriedmann/oh-my-zsh/master/tools/install.sh)"
