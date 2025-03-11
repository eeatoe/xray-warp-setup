#!/bin/bash

set -e # Останавливаем выполнение при ошибке

# Загружаем переменные из .env
export $(cat .env | xargs)

# Обновляем систему
apt update && apt upgrade -y

# Устанавливаем Docker и Docker Compose
sudo apt install -y docker.io docker-compose

# Клонируем репозиторий с конфигами
git clone https://github.com/eeatoe/xray-warp-setup.git /opt/xray-warp
cd /opt/xray-warp

# Собираем кастомные образы
docker build -t my_xray ./xray
docker build -t my_warp ./warp

# Используем envsubst для подстановки переменных в config.json
envsubst < /path/to/xray/config.template.json > /etc/xray/config.json

# Запускаем xray и warp
docker-compose up -d

# Проверяем работают ли контейнеры
docker ps
