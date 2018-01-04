FROM ubuntu:16.04

#ARG http_proxy
#ARG https_proxy

RUN echo '\
deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted \
deb-src http://mirrors.aliyun.com/ubuntu/ xenial main restricted multiverse universe #Added by software-properties\
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted\
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted multiverse universe #Added by software-properties\
deb http://mirrors.aliyun.com/ubuntu/ xenial universe\
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates universe\
deb http://mirrors.aliyun.com/ubuntu/ xenial multiverse\
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates multiverse\
deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse\
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse #Added by software-properties\
deb http://archive.canonical.com/ubuntu xenial partner\
deb-src http://archive.canonical.com/ubuntu xenial partner\
deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted\
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted multiverse universe #Added by software-properties\
deb http://mirrors.aliyun.com/ubuntu/ xenial-security universe\
deb http://mirrors.aliyun.com/ubuntu/ xenial-security multiverse \'>/etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y python-pip --fix-missing

ADD requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

VOLUME ["/var/app"]

ADD run.sh /var/run.sh

EXPOSE 5000
ENV APP_VERSION V1.0

CMD chmod +x /var/run.sh && /var/run.sh

