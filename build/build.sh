
VERSION=1.4.9
JUMPSDIR=jumpserver
COCODIR=coco

JUMPSTAG=jms/jumpserver
COCOTAG=jms/coco

JMPSCONF=config.yml.jmps
COCOCONF=config.yml.coco


REDIS_HOST=jmsredis
REDIS_PORT=6379
REDIS_PASSWORD=redis123

DB_HOST=jmsmysql
DB_PORT=3306
DB_NAME=jumpserver
DB_USER=jumpserver
DB_PASSWORD=mysql123

CORE_HOST=http://jumpserver:8080

echo -e "\n date `date '+%F %H:%M:%S'` \n" >> ./keytxt

SECRET_KEY=`cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 50`
echo "SECRET_KEY=$SECRET_KEY" >> ./keytxt

BOOTSTRAP_TOKEN=`cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 16`
echo "BOOTSTRAP_TOKEN=$BOOTSTRAP_TOKEN" >> ./keytxt

# create jmps/coco config

gen_jmps_conf(){
if [ ! -f "./${JMPSCONF}" ]
then
    \cp ./config_jmps.tpl ./${JMPSCONF}
    sed -i "s/SECRET_KEY:/SECRET_KEY: $SECRET_KEY/g" ./${JMPSCONF}
    sed -i "s/BOOTSTRAP_TOKEN:/BOOTSTRAP_TOKEN: $BOOTSTRAP_TOKEN/g" ./${JMPSCONF}
    sed -i "s/# DEBUG: true/DEBUG: false/g" ./${JMPSCONF}
    sed -i "s/# LOG_LEVEL: DEBUG/LOG_LEVEL: INFO/g" ./${JMPSCONF}
    sed -i "s/# SESSION_EXPIRE_AT_BROWSER_CLOSE: false/SESSION_EXPIRE_AT_BROWSER_CLOSE: true/g" ./${JMPSCONF}
    sed -i "s/DB_HOST: 127.0.0.1/DB_HOST: $DB_HOST/g" ./${JMPSCONF}
    sed -i "s/DB_PORT: 3306/DB_PORT: $DB_PORT/g" ./${JMPSCONF}
    sed -i "s/DB_USER: jumpserver/DB_USER: $DB_USER/g" ./${JMPSCONF}
    sed -i "s/DB_PASSWORD: /DB_PASSWORD: $DB_PASSWORD/g" ./${JMPSCONF}
    sed -i "s/DB_NAME: jumpserver/DB_NAME: $DB_NAME/g" ./${JMPSCONF}
    sed -i "s/REDIS_HOST: 127.0.0.1/REDIS_HOST: $REDIS_HOST/g" ./${JMPSCONF}
    sed -i "s/REDIS_PORT: 6379/REDIS_PORT: $REDIS_PORT/g" ./${JMPSCONF}
    sed -i "s/# REDIS_PASSWORD: /REDIS_PASSWORD: $REDIS_PASSWORD/g" ./${JMPSCONF}
    echo "generate jumpserver config.yml finished"
fi
}

gen_coco_conf(){
if [ ! -f "./${COCOCONF}" ]
then
    \cp ./config_coco.tpl ./${COCOCONF}
    sed -i 's/^CORE_HOST/#CORE_HOST/g'  ./${COCOCONF}
    sed -i "/CORE_HOST/a\CORE_HOST: $CORE_HOST"  ./${COCOCONF}
    sed -i 's/^BOOTSTRAP_TOKEN/#BOOTSTRAP_TOKEN/g'  ./${COCOCONF}
    sed -i "/BOOTSTRAP_TOKEN/a\BOOTSTRAP_TOKEN: $BOOTSTRAP_TOKEN"  ./${COCOCONF}
    sed -i "/SECRET_KEY/a\SECRET_KEY: $SECRET_KEY"  ./${COCOCONF}
    echo "generate coco config.yml finished "
fi
}

# build centos7-py36 images
build_baseimg(){
if [ -f "./centos7-py36/Dockerfile.pip3" ]
then
    docker build -t jms/centos7-py36:latest -f ./centos7-py36/Dockerfile.pip3 .
    echo "########## centos7-py36 images build finished ##########"
    docker images |grep centos7-py36
fi
}

# build jumps images

download_jumps(){
JMSURL=https://codeload.github.com/jumpserver/jumpserver/tar.gz/${VERSION}

wget -O jumpserver-${VERSION}.tar.gz  ${JMSURL}

tar zxvf jumpserver-${VERSION}.tar.gz  
}

build_jmps(){
[ ! -d ./jumpserver-${VERSION} ] && download_jumps

if [ -f "./config.yml.jmps" ]
then
\cp ./config.yml.jmps  jumpserver-${VERSION}/config.yml
\cp ./${JUMPSDIR}/Dockerfile.jms  jumpserver-${VERSION}/Dockerfile
\cp ./${JUMPSDIR}/entrypoint.sh.jms   jumpserver-${VERSION}/entrypoint.sh
chmod 755 jumpserver-${VERSION}/*.sh
fi

cd jumpserver-${VERSION}
sed -i 's/^STATIC_ROOT/#STATIC_ROOT/g'  ./apps/jumpserver/settings.py
sed -i '/STATIC_ROOT/a\STATIC_ROOT = "/opt/static"' ./apps/jumpserver/settings.py

if [ -f "./Dockerfile" ]
then
docker build -t ${JUMPSTAG}:${VERSION} .
docker tag ${JUMPSTAG}:${VERSION} ${JUMPSTAG}
fi

echo "########## jumps images build finished ##########"
docker images |grep ${JUMPSTAG}

cd ..
echo current DIR : $PWD
}

# build coco images

download_coco(){
COCOURL=https://github.com/jumpserver/coco/archive/${VERSION}.tar.gz

wget -O coco-${VERSION}.tar.gz  ${COCOURL}

tar zxvf coco-${VERSION}.tar.gz
}

build_coco(){
[ ! -d ./coco-${VERSION} ] && download_coco

if [ -f "./config.yml.coco" ]
then
\cp ./config.yml.coco  coco-${VERSION}/config.yml
\cp ./${COCODIR}/Dockerfile.coco  coco-${VERSION}/Dockerfile
\cp ./${COCODIR}/entrypoint.sh.coco    coco-${VERSION}/entrypoint.sh
chmod 755 coco-${VERSION}/*.sh
fi

cd coco-${VERSION}

if [ -f "./Dockerfile" ] 
then
docker build -t ${COCOTAG}:${VERSION} .
docker tag ${COCOTAG}:${VERSION} ${COCOTAG}
fi

echo "coco images build finished"
docker images |grep ${COCOTAG}
cd ..
}

gen_jmps_conf
gen_coco_conf

build_baseimg

build_jmps
build_coco

