#!/bin/bash
set -euo pipefail

if [ -z "$1" ]; then
    echo "Użycie: $0 <ścieżka_do_folderu> <liczba_dni>"
    echo "Przykład: $0 ./logs 30"
    exit 1
fi

TARGET_DIR="$1"
DAYS_OLD="$2"

if [ -z "$DAYS_OLD" ]; then
    DAYS_OLD=30
fi

if [ ! -d "$TARGET_DIR" ]; then
    echo "BŁĄD: Folder '$TARGET_DIR' nie istnieje."
    exit 1
fi

echo "Sprzątam w: $TARGET_DIR (usuwam pliki starsze niż $DAYS_OLD dni)"

for plik in "$TARGET_DIR"/*.log; do
    if [ -f "$plik" ]; then
        if [ -n "$(find "$plik" -mtime +"$DAYS_OLD")" ]; then
            echo "Usuwam przestarzały plik: $plik"
            rm "$plik"
        fi
    fi
done

echo "Zakończono sprzątanie."
