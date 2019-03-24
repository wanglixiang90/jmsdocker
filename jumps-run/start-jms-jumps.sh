
basedir=/opt/jmsrun/jumps

docker run -d --name jms_jumpserver \
-v ${basedir}/data:/opt/jumpserver/data \
-v ${basedir}/logs:/opt/jumpserver/logs \
-p 8080:8080 \
--add-host jms_mysql:192.168.2.55 \
--add-host jms_redis:192.168.2.55 \
jms/jumpserver
