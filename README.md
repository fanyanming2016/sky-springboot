# SkyWalking验证SpringBoot框架 

## 构建 skywalking agent 基础镜像
1. 下载skywalking 二进制包并解压
```$xslt
wget https://www.apache.org/dyn/closer.cgi/skywalking/6.3.0/apache-skywalking-apm-7.0.0.tar.gz && tar -zxvf apache-skywalking-apm-7.0.0.tar.gz
MacBook-Pro:apache-skywalking-apm-bin-es7 root$ ls
Dockerfile		LICENSE			README.txt		bin			licenses		tools
Dockerfile.tomcat	NOTICE			agent			config			oap-libs		webapp
```
2. 在解压的根目录下，编写dockerfile
```$xslt
FROM openjdk:8-jre-alpine
ENV LANG=C.UTF-8
ENV TZ=Asia/Shanghai
COPY agent/ /skywalking/agent/
```
3. 构建基础镜像
```shell
# 项目根目录下执行
docker build -t openjdk:sk-8-jre .
```

## 构建应用镜像

```shell
# 项目根目录下执行
docker build -t sk-test:v0.1 .
```

## 运行应用

```$xslt
docker run -e SW_COLLECTOR_SERVERS={你的ip}:11800 -e SW_SERVICE_NAME=sk-test -p 10010:10010 sk-test:v0.1
```