#!/bin/bash

VPN_NAME="ИмяVPN"  # Замените на имя вашего VPN

# Проверяем статус VPN
STATUS=$(scutil --nc list | grep "$VPN_NAME" | awk '{print $2}')

if [ "$STATUS" = "(Connected)" ]; then
    # Если VPN подключен - отключаем
    scutil --nc stop "$VPN_NAME"
    echo "VPN ($VPN_NAME) отключен."
else
    # Если VPN отключен - подключаем
    scutil --nc start "$VPN_NAME"
    echo "VPN ($VPN_NAME) подключен."
fi
