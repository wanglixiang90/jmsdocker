
REDIS_HOST=192.168.2.55
REDIS_PORT=6379
REDIS_PASSWORD=jlnetrds389hz

DB_HOST=192.168.2.55
DB_PORT=3306
DB_NAME=jumpserver
DB_USER=jumpserver
DB_PASSWORD=jlnet389hz

echo -e "\n date `date '+%F %H:%M:%S'` \n" >> ./keytxt

SECRET_KEY=`cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 50`
echo "SECRET_KEY=$SECRET_KEY" >> ./keytxt

BOOTSTRAP_TOKEN=`cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 16`
echo "BOOTSTRAP_TOKEN=$BOOTSTRAP_TOKEN" >> ./keytxt

if [ ! -f "./config.yml" ]; then
    cp ./config_example.yml ./config.yml
    sed -i "s/SECRET_KEY:/SECRET_KEY: $SECRET_KEY/g" ./config.yml
    sed -i "s/BOOTSTRAP_TOKEN:/BOOTSTRAP_TOKEN: $BOOTSTRAP_TOKEN/g" ./config.yml
    sed -i "s/# DEBUG: true/DEBUG: false/g" ./config.yml
    sed -i "s/# LOG_LEVEL: DEBUG/LOG_LEVEL: INFO/g" ./config.yml
    sed -i "s/# SESSION_EXPIRE_AT_BROWSER_CLOSE: false/SESSION_EXPIRE_AT_BROWSER_CLOSE: true/g" ./config.yml
    sed -i "s/DB_HOST: 127.0.0.1/DB_HOST: $DB_HOST/g" ./config.yml
    sed -i "s/DB_PORT: 3306/DB_PORT: $DB_PORT/g" ./config.yml
    sed -i "s/DB_USER: jumpserver/DB_USER: $DB_USER/g" ./config.yml
    sed -i "s/DB_PASSWORD: /DB_PASSWORD: $DB_PASSWORD/g" ./config.yml
    sed -i "s/DB_NAME: jumpserver/DB_NAME: $DB_NAME/g" ./config.yml
    sed -i "s/REDIS_HOST: 127.0.0.1/REDIS_HOST: $REDIS_HOST/g" ./config.yml
    sed -i "s/REDIS_PORT: 6379/REDIS_PORT: $REDIS_PORT/g" ./config.yml
    sed -i "s/# REDIS_PASSWORD: /REDIS_PASSWORD: $REDIS_PASSWORD/g" ./config.yml
fi

echo "gen config.yml finished "
