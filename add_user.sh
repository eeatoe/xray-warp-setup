#!/bin/bash

CONFIG_PATH="/etc/xray/config.json"

# Проверяем, передано ли имя пользователя
if [ -z "$1" ]; then
  echo "Ошибка: укажите имя пользователя!"
  echo "Пример: ./add_user.sh username"
  exit 1
fi

USERNAME=$1
UUID=$(uuidgen)  # Генерируем уникальный ID
USER_TAG="${USERNAME}@vpn"  # Формируем человекочитаемый тег


# Добавляем нового пользователя в конфиг
jq --arg uuid "$UUID" --arg tag "$USER_TAG" '.inbounds[0].settings.clients += [{"id": $uuid, "email": $tag}]' $CONFIG_PATH > tmp.json && mv tmp.json $CONFIG_PATH

# Перезапускаем контейнер Xray
docker restart xray

# Вывод сообщения об успешном добовление
echo "Добавлен пользователь: $USER_TAG ($UUID)"