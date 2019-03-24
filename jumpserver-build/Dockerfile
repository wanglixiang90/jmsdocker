FROM jms/centos7-py36:latest
MAINTAINER Wanglx <15201376500@163.com>

WORKDIR /opt/jumpserver
RUN useradd jumpserver

COPY . /opt/jumpserver

RUN yum -y install epel-release openldap-clients telnet && \
    yum -y install $(cat /opt/jumpserver/requirements/rpm_requirements.txt) && \
	python3.6 -m venv /opt/py3 && \
    	source /opt/py3/bin/activate && \
	pip install --upgrade pip setuptools && \
	pip install -i https://pypi.doubanio.com/simple/ django && \
	pip install -r /opt/jumpserver/requirements/requirements.txt && \
	yum clean all && rm -rf /var/cache/yum/* && \
	rm -rf ~/.cache/pip 

VOLUME /opt/jumpserver/data
VOLUME /opt/jumpserver/logs

ENV LANG=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8

EXPOSE 8080
ENTRYPOINT ["./entrypoint.sh"]
