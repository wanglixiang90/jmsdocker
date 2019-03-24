FROM mysql/mysql-server:5.7
MAINTAINER Wanglx <15201376500@163.com>

ADD my.cnf /etc/my.cnf

RUN set -ex \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && yum -y install kde-l10n-Chinese \
	&& yum -y reinstall glibc-common \
    && localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8 \
    && export LC_ALL=zh_CN.UTF-8 \
    && echo 'LANG="zh_CN.UTF-8"' > /etc/locale.conf \
    && yum clean all \
    && rm -rf /var/cache/yum/*
	
ENV LC_ALL "zh_CN.UTF-8"