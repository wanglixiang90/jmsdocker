
VERSION=1.4.9

LURL=https://github.com/jumpserver/luna/releases/download/${VERSION}/luna.tar.gz

SURL=https://github.com/wanglixiang90/jmsdocker/raw/dev/build/nginx/static.tar.gz

if [ ! -d ./luna ]
then
wget -O luna.tar.gz  ${LURL}
tar zxf luna.tar.gz
fi

if [ ! -d ./static ]
then
wget -O static.tar.gz ${SURL}
tar zxf static.tar.gz
fi

if [ -f ./Dockerfile.ngx ]
then
docker build -t jms/nginx_web -f Dockerfile.ngx .
fi

