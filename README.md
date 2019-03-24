# jmsdocker

## build jumpserver docker images
1. git clone jmsdocker <br>
	```
	git clone https://github.com/wanglixiang90/jmsdocker.git 
	```
2. build base python3.6 images <br>
	```
	cd  base-py36/
	docker build -t jms/centos7-py36:latest .
	```
3. build jumpserver v1.4.8 <br>
```
	cd  ../jumpserver-build/
	docker build -t jms/jumpserver .
```
4. build coco v1.4.8 <br>
```
	cd  ../coco-build/
	docker build -t jms/coco .
```
5. build nginx with luna/static <br>
```
	cd ../nginx-build/
	docker build -t jms/nginx_web .
```
6. build mysql and redis <br>
```
	cd ../mysql57
	docker build -t jms/mysql57-utf8 .
	cd  ../redis
	docker pull bitnami/redis 
	docker tag bitnami/redis jms/redis
```
## run jumpserver by docker <br>
1. start mysql redis <br>
```
	./start-jms-redis.sh
	cd ../mysql57
	./start-jms-mysql57.sh
```
2. config mysql/redis ip,start jumpserver core api <br>
```
	cd ../jumps-run
	./start-jms-jumps.sh
```
3. config jumpserver core api ip,start ssg coco service <br>
```
	cd ../coco-run
	./start-jms-coco.sh
```
4. config jumpserver/coco service ip,start nginx proxy <br>
```
	cd ../nginx-run
	./start-jms-nginx-web.sh
```
## visit jumpserver site
 http://nginx_ip/

This jumpserver not support windows RDP,  <br>
if need windows RDP plz pull guacamole images <br>
```
	docker pull jumpserver/jms_guacamole:1.4.8 
```
