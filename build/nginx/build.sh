
VERSION=1.4.9

LURL=https://github.com/jumpserver/luna/releases/download/${VERSION}/luna.tar.gz

SURL=VAR

if [ ! -d ./luna.tar.gz ]
then
wget ${LURL}
tar zxf luna.tar.gz
fi

if [ ! -d ./static.tar.gz ]
then
wget ${SURL}
tar zxf static.tar.gz
fi

if [ -d ./Dockerfile.ngx ]
then
docker build -t jms/nginx_web -f Dockerfile.ngx .
fi
