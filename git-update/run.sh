#!/usr/bin/env bash
cd /var/github
if [ ! -d /var/github/flask-demo ];then
    git clone https://github.wanda-itg.local/liaobo6/flask-demo.git
fi
while true; do
    sleep 30
    cd /var/github/flask-demo
    date
    git pull
done
