datadir=/opt/jmsrun/redis/data

docker run --name jms-redis -d  --restart=always \
-p 6379:6379 \
-v ${datadir}:/bitnami \
-e REDIS_PASSWORD=redispasswd \
jms/redis
