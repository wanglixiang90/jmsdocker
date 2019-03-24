FROM jms/centos7-py36:latest
MAINTAINER Wanglx <15201376500@163.com>

WORKDIR /opt/coco
COPY . /opt/coco

RUN yum -y install epel-release openldap-clients telnet && \
    yum -y install $(cat /opt/coco/requirements/rpm_requirements.txt) && \
	python3.6 -m venv /opt/py3 && \
    source /opt/py3/bin/activate && \
	pip install --upgrade pip setuptools && \
	pip install -r /opt/coco/requirements/requirements.txt && \
	yum clean all && rm -rf /var/cache/yum/* && \
	rm -rf ~/.cache/pip 

ENV LANG=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8

VOLUME /opt/coco/data

EXPOSE 2222
ENTRYPOINT ["./entrypoint.sh"]
