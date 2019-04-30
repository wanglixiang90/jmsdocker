
VERSION=1.4.9

download_tar(){
JMSURL=https://codeload.github.com/jumpserver/jumpserver/tar.gz/${VERSION}

wget -O jumpserver-${VERSION}.tar.gz  ${JMSURL}

tar zxvf jumpserver-${VERSION}.tar.gz  
}

[ ! -f ./jumpserver-${VERSION}.tar.gz ] && download_tar

cp jumpserver-${VERSION}/config_example.yml .
./gen_key.sh

if [ -f "./config.yml" ]
then
\cp ./config.yml  jumpserver-${VERSION}/
\cp ./Dockerfile.jms  jumpserver-${VERSION}/
\cp ./start_jms.sh jumpserver-${VERSION}/entrypoint.sh
chmod 755 jumpserver-${VERSION}/*.sh
fi

cd  jumpserver-${VERSION}
sed -i 's/^STATIC_ROOT/#STATIC_ROOT/g'  ./apps/jumpserver/settings.py
sed -i '/STATIC_ROOT/a\STATIC_ROOT = "/opt/static"' ./apps/jumpserver/settings.py

if [ -f "./Dockerfile.jms" ] 
then
dockerbuild -t jms/jumpserver:${VERSION} -f Dockerfile.jms .

docker tag jms/jumpserver:${VERSION} jms/jumpserver
fi
