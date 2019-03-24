
basedir=/opt/jmsrun/nginx
datadir=/opt/jmsrun/jumps/data

docker run -d --name  jms-nginx-web \
-v ${basedir}/logs:/var/log/nginx \
-v ${datadir}:/opt/jumpserver/data \
-p 80:80  -p 2222:2222 \
--add-host jmsjumps:192.168.2.55 \
--add-host jmscoco:192.168.2.55 \
--add-host jmsguac:192.168.2.55 \
jms/nginx_web 
