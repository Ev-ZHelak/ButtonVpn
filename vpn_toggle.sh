#!/bin/bash

VPN_NAME="ИмяVPN"  # Замените на имя вашего VPN

# Проверяем статус VPN
STATUS=$(scutil --nc list | grep "$VPN_NAME" | awk '{print $2}')

if [ "$STATUS" = "(Connected)" ]; then
    # Если VPN подключен — отключаем
    if scutil --nc stop "$VPN_NAME"; then
        osascript -e "display notification \"VPN $VPN_NAME отключен\" with title \"Готово!\"" # Системное уведомление
        echo "VPN успешно отключён"
    else
        osascript -e "display notification \"При отключении VPN $VPN_NAME\" with title \"Ошибка!\"" 
        echo "Ошибка при отключении VPN"
    fi
elif [ "$STATUS" = "(Disconnected)" ]; then
    # Если VPN отключен — подключаем
    if scutil --nc start "$VPN_NAME"; then
        osascript -e "display notification \"VPN $VPN_NAME подключен\" with title \"Готово!\""
        echo "VPN успешно подключён"
    else
        osascript -e "display notification \"При подключении VPN $VPN_NAME\" with title \"Ошибка!\"" 
        echo "Ошибка при подключении VPN"
    fi
else 
    # Если VPN не существует
    osascript -e "display notification \"VPN $VPN_NAME не существует\" with title \"Ошибка!\"" 
    echo "Ошибка не существует VPN $VPN_NAME"
fi
