#!/bin/bash

VPN_NAME="ИмяVPN"  # Замените на имя вашего VPN

# Проверяем статус VPN
STATUS=$(scutil --nc list | grep "$VPN_NAME" | awk '{print $2}')

if [ "$STATUS" = "(Connected)" ]; then
    # Если VPN подключен — отключаем
    if scutil --nc stop "$VPN_NAME"; then
        osascript -e "display notification \"VPN $VPN_NAME отключен\" with title \"Готово!\"" # Системное уведомление
        echo "VPN $VPN_NAME отключен"
    else
        osascript -e "display notification \"При отключении VPN $VPN_NAME\" with title \"Ошибка!\"" 
        echo "Ошибка при отключении VPN $VPN_NAME"
    fi
elif [ "$STATUS" = "(Disconnected)" ]; then
    # Если VPN отключен — подключаем
    if scutil --nc start "$VPN_NAME"; then
        osascript -e "display notification \"VPN $VPN_NAME подключен\" with title \"Готово!\""
        echo "VPN $VPN_NAME подключен"
    else
        osascript -e "display notification \"При подключении VPN $VPN_NAME\" with title \"Ошибка!\"" 
        echo "Ошибка при подключении VPN $VPN_NAME"
    fi
else 
    # Если VPN не существует
    osascript -e "display notification \"VPN $VPN_NAME не существует\" with title \"Ошибка!\"" 
    echo "Ошибка VPN $VPN_NAME не существует"
fi
