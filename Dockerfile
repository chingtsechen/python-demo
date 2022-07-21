# This my first django Dockerfile
# Version 1.0

# Base images 基礎鏡像
FROM harbor.momoshop.com.tw/centos/centos:centos7.9.2009

#MAINTAINER 維護者訊息
LABEL maintainer gtchen

#ENV 設置環境變量
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
#ENV 設置代理
ENV http_proxy http://10.3.15.81:3128
ENV https_proxy http://10.3.15.81:3128

#RUN 執行以下指令
RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
RUN yum install -y  python36 python3-devel gcc pcre-devel zlib-devel make net-tools nginx

#工作目錄
WORKDIR /opt/myblog

#拷貝文建至工作目錄
COPY . .

#拷貝nginx配置文件
COPY myblog.conf /etc/nginx

#安裝依賴的插件
RUN pip3 install -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com -r requirements.txt

RUN chmod +x run.sh && rm -rf ~/.cache/pip

#EXPOSE 映射端口
EXPOSE 8002

#容器啟動時執行命令
CMD ["./run.sh"]
