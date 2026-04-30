#!/bin/bash
set -euo pipefail

BACKUP_DIR="$HOME/scripts/backup"
LOG_DIR="$HOME/scripts/logs"
LOG_FILE="$LOG_DIR/system.log"
DAYS_TO_KEEP=7 


log() {
    local LEVEL="$1"
    local MESSAGE="$2"
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [$LEVEL] $MESSAGE" >> "$LOG_FILE"
}

log "INFO" "Uruchamiam czyszczenie plików starszych niż $DAYS_TO_KEEP dni w: $BACKUP_DIR"

if [ ! -d "$BACKUP_DIR" ]; then
    log "ERROR" "Katalog $BACKUP_DIR nie istnieje. Kończę pracę."
    exit 1
fi


FILES=$(find "$BACKUP_DIR" -maxdepth 1 -name "*.tar.gz" -type f -mtime +$DAYS_TO_KEEP)

if [ -z "$FILES" ]; then
    log "INFO" "Brak plików do usunięcia. Dysk jest czysty."
else
    echo "$FILES" | while read -r file; do
        if rm -f "$file"; then
            log "INFO" "Usunięto stary backup: $(basename "$file")"
        else
            log "ERROR" "Nie udało się usunąć pliku: $file"
        fi
    done
    log "INFO" "Proces czyszczenia zakończony."
fi