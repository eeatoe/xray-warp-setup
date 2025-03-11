# Используем образ Alpine Linux для сборки xray
FROM alpine:latest

# Устанавливаем зависимости
RUN apk add --no-cache curl unzip coreutils \
    bash && \
    mkdir -p /usr/local/bin/xray && \
    cd /usr/local/bin/xray && \
    curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip -o xray.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/xray && \
    rm -f xray.zip

# Копируем конфиг
COPY config.json /etc/xray/config.json

# Открываем порты для Xray и Prometheus
EXPOSE 443 10085

# Запускаем Xray
CMD ["/usr/bin/xray" "-config" "/etc/xray/config.json"]
