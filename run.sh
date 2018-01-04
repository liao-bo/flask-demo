#!/usr/bin/env bash
while [ ! -d /var/app/flask-demo ]; do
    date
    echo "waiting github clone"
    sleep 30
done
APP_PATH=/var/app/flask-demo
python ${APP_PATH}/app.py
