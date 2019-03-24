
datadir=/opt/jmsrun/mysql57/mysql

docker run -d --name jms-mysql57-utf8 --privileged=true  --restart=always \
-v ${datadir}:/var/lib/mysql \
-p 3306:3306 \
-e MYSQL_ROOT_HOST='%' \
-e MYSQL_ROOT_PASSWORD=mysqlpasswd \
jms/mysql57-utf8
