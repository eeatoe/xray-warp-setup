# Используем образ Alpine Linux для сборки xray
FROM alpine:latest

# Устанавливаем зависимости
RUN apk add --no-cache \
    curl \
    unzip \
    sha256sum \
    bash \
    && mkdir -p /usr/local/bin/xray \
    && cd /usr/local/bin/xray \

    # Скачиваем Xray и файл с Hash-суммой
    && curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    && curl -L -o xray-hash.zip.dgst https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip.dgst \

    # Извлекаем SHA256 хеш-сумму из файла .dgst и сохраняем ее в файл
    && grep "SHA2-256" Xray-linux-64.zip.dgst | awk '{print $2}' > xray.zip.sha256 \

    # Проверяем хеш-сумму скачанного архива
    && sha256sum -c xray.zip.sha256 || (echo "Hash-и не сходятся! Остановка." && exit 1) \

    # Распаковываем и устанавливаем Xray
    && unzip xray.zip -d /usr/local/bin/ \
    && chmod +x /usr/local/bin/xray \

    # Удаляем временные файлы
    && rm -f xray.zip Xray-linux-64.zip.dgst xray.zip.sha256

# Копируем конфиг
COPY config.json /etc/xray/config.json

# Открываем порты для Xray и Prometheus
EXPOSE 443 10085

# Запускаем Xray
CMD ["/usr/bin/xray" "-config" "/etc/xray/config.json"]
