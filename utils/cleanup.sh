#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"

TARGET_DIR="${1:-}"

DAYS_OLD="${2:-30}"

if [ -z "$TARGET_DIR" ]; then
    echo "Użycie: $0 <ścieżka_do_folderu> [liczba_dni]"
    
    echo "Przykład: $0 \"$BASE_DIR/logs\" 14"
    echo "Domyślna liczba dni: 30"
    exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then
    echo "BŁĄD: Folder '$TARGET_DIR' nie istnieje."
    exit 1
fi

echo "Sprzątam w: $TARGET_DIR (usuwam pliki *.log starsze niż $DAYS_OLD dni)..."

FILES=$(find "$TARGET_DIR" -maxdepth 1 -name "*.log" -type f -mtime +"$DAYS_OLD")

if [ -z "$FILES" ]; then
    echo "Brak starych plików logów do usunięcia."
else
    echo "$FILES" | while read -r file; do
        if [ -n "$file" ]; then
            echo "Usuwam przestarzały plik: $(basename "$file")"
            rm -f "$file"
        fi
    done
fi

echo "Zakończono sprzątanie."