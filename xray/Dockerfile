# Используем образ Alpine Linux для сборки xray
FROM alpine:latest

# Устанавливаем зависимости
RUN apk add --no-cache curl unzip coreutils bash && \
    mkdir -p /usr/local/bin && \
    cd /usr/local/bin && \
    curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip -o xray.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/xray && \
    rm -f xray.zip

# Копируем конфиг
RUN envsubst < xray-warp-setup/xray/config.template.json > xray-warp-setup/xray/config.json

COPY config.template.json /etc/xray/config.json

# Открываем порты для Xray и Prometheus
EXPOSE 443 10085

# Запускаем Xray
CMD ["/usr/bin/xray" "-config" "/etc/xray/config.json"]
