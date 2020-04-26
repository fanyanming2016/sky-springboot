# 第一阶段
FROM maven:3.6-openjdk-8-slim as builder
# 设置工作目录
ENV WORK_PATH=/workplace
WORKDIR  $WORK_PATH
# 将代码拷贝到工作目录
COPY . .
# 使用国内镜像setting.xml配置
RUN mvn clean package --settings settings.xml -U -DskipTests

# 第二阶段
FROM openjdk:sk-8-jre
ENV SW_COLLECTOR_SERVERS=127.0.0.1:11800 \
    SW_SERVICE_NAME=docker-boot
ENV WORK_PATH=/app
#从名为builder复制构建jar到工作目录
COPY --from=builder /workplace/target/*.jar sk-demo.jar
COPY --from=builder /workplace/run.sh run.sh

EXPOSE 10010
# 启动
CMD ["sh", "run.sh"]

