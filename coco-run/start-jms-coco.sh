
basedir=/opt/jmsrun/coco

docker run -d --name jms_coco \
-v ${basedir}/data:/opt/coco/data \
-v ${basedir}/logs:/opt/coco/logs \
-p 5000:5000 -p 3222:2222 \
--add-host jumpserver:192.168.2.55 \
--add-host jms_mysql:192.168.2.55 \
--add-host jms_redis:192.168.2.55 \
jms/coco
