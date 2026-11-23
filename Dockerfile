
FROM alpine:3.21

RUN apk add --no-cache ca-certificates wget unzip \
    && mkdir -p /opt/xray \
    && wget -q -O /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/v1.8.24/Xray-linux-64.zip \
    && unzip -o /tmp/xray.zip -d /opt/xray \
    && chmod +x /opt/xray/xray \
    && rm /tmp/xray.zip

EXPOSE 8080

CMD ["/bin/sh", "-c", "printf '%s' \"$XRAY_CONFIG_B64\" | base64 -d > /opt/xray/config.json && exec /opt/xray/xray run -config /opt/xray/config.json"]
