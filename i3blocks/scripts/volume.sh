#!/bin/bash


# Проверяем, работает ли PipeWire
if ! command -v wpctl &>/dev/null; then
    echo "VOL: NO_PIPE"
    exit 1
fi

# Получаем статус звука
volume_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)

# Если команда не сработала
if [ $? -ne 0 ]; then
    echo "VOL: ERROR"
    exit 1
fi

# Парсим вывод
if [[ "$volume_info" == *"MUTED"* ]]; then
    echo "VOL: MUTED"
else
    # Извлекаем уровень громкости (например, "0.57" -> 57%)
    volume=$(echo "$volume_info" | awk '{print int($2 * 100)}')
    echo "VOL: ${volume}%"
fi
