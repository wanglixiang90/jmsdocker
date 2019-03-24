FROM centos:latest
MAINTAINER Wanglx <15201376500@163.com>

WORKDIR /opt

RUN set -ex \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && yum -y install kde-l10n-Chinese \
    && yum -y reinstall glibc-common \
    && localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8 \
    && export LC_ALL=zh_CN.UTF-8 \
    && echo 'LANG="zh_CN.UTF-8"' > /etc/locale.conf \
    && yum -y install wget gcc epel-release \
    && yum -y install python36 python36-devel python-pip libtool \
    && yum clean all \
    && rm -rf /var/cache/yum/*
