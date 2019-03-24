#!/bin/bash
function cleanup()
{
    local pids=`jobs -p`
    if [[ "${pids}" != ""  ]]; then
        kill ${pids} >/dev/null 2>/dev/null
    fi
}

python3.6 -m venv /opt/py3
source /opt/py3/bin/activate
export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8

service="all"
if [[ "$1" != "" ]];then
    service=$1
fi

trap cleanup EXIT
if [[ "$1" == "bash" ]];then
    bash
else
    python jms start ${service}
fi

