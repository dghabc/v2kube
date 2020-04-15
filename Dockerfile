# 指定创建的基础镜像
FROM alpine
# 作者信息
MAINTAINER alpine_nginx danxiaonuo
# 语言设置
ENV LANG en_US.UTF-8
# 时区设置
ENV TZ=Asia/Shanghai
# 设置CONFIG_JSON为空
ENV CONFIG_JSON=none
# 修改源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
# 同步时间
RUN apk add -U tzdata && \
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo 'Asia/Shanghai' > /etc/timezone
# 安装v2ray
RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
 && curl -L -H "Cache-Control: no-cache" -o /v2ray.zip https://github.com/v2ray/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
 && mkdir /usr/bin/v2ray /etc/v2ray \
 && touch /etc/v2ray/config.json \
 && unzip /v2ray.zip -d /usr/bin/v2ray \
 && rm -rf /v2ray.zip /usr/bin/v2ray/*.sig /usr/bin/v2ray/doc /usr/bin/v2ray/*.json /usr/bin/v2ray/*.dat /usr/bin/v2ray/sys* \
 && chgrp -R 0 /etc/v2ray \
 && chmod -R g+rwX /etc/v2ray
 # 增加脚本
ADD configure.sh /configure.sh
# 授权脚本权限
RUN chmod +x /configure.sh
# 运行脚本
ENTRYPOINT /configure.sh
# 暴露端口
EXPOSE 8080
