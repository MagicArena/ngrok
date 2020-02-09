FROM alpine:latest

LABEL cn.magicarnea.description="Ngrok client docker image based on alpine." \
      cn.magicarnea.vendor="MagicArena" \
      cn.magicarnea.maintainer="everoctivian@gmail.com" \
      cn.magicarnea.versionCode=1 \
      cn.magicarnea.versionName="1.0.0"

VOLUME ["/etc/ngrok"]

# if you want use APK mirror then uncomment, modify the mirror address to which you favor
#RUN sed -i 's|http://dl-cdn.alpinelinux.org|https://mirrors.aliyun.com|g' /etc/apk/repositories

ENV TIME_ZONE=Asia/Shanghai
RUN set -ex && \
    apk add --no-cache tzdata ca-certificates && \
    ln -snf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && \
    echo ${TIME_ZONE} > /etc/timezone && \
    rm -rf /tmp/* /var/cache/apk/*

COPY ./usr/bin/ngrok /usr/bin/ngrok
RUN chmod +x /usr/bin/ngrok

ENTRYPOINT ["/usr/bin/ngrok", "-config=/etc/ngrok/ngrok.yml", "-proto=http+https+tcp", "-log=stdout", "-log-level=DEBUG", "start-all"]