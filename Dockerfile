FROM alpine:3.6

LABEL maintainer="fredliang <info@fredliang.cn>"

WORKDIR /var/frp

RUN curl -s https://api.github.com/repos/fatedier/frp/releases/latest \
| grep "browser_download_url.*linux_amd64.tar.gz"  \
| cut -d : -f 2,3 \
| tr -d '\"' \
| wget -i -

RUN apk update && apk add zip bash tzdata \
    && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && tar -zxf frp*.tar.gz && rm -rf frp*.tar.gz \
    && mv frp_*_linux_amd64/frps /var/frp/frps \
    && rm -rf frp_*_linux_amd64

ENTRYPOINT /var/frp/frps -c /var/frp/conf/frps.ini