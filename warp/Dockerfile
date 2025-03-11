# Используем минимальный образ Debian
FROM debian:latest

WORKDIR /app

# Устанавливаем необходимые утилиты
RUN apt update && apt install -y curl gnupg lsb-release


# Устанавливаем warp по инструкции с сайта https://pkg.cloudflareclient.com/

# Добавляем GPG-ключ Cloudflare
RUN curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor -o /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg

# Добавляем репозиторий Cloudflare WARP
RUN echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/cloudflare-client.list

# Устанавливаем WARP
RUN apt update && apt install -y cloudflare-warp

# Добавляем WARP+ ключ из переменной окружения и активируем
ARG WARP_PLUS_KEY
RUN warp-cli register && warp-cli set-license $WARP_PLUS_KEY

# Запускаем WARP при старте контейнера
CMD warp-cli connect && tail -f /dev/null
