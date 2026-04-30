#!/bin/bash
set -euo pipefail

SOURCE_DIR="$HOME/scripts"
BACKUP_DIR="$HOME/scripts/backup"
LOG_DIR="$HOME/scripts/logs"
LOG_FILE="$LOG_DIR/system.log"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
FILENAME="backup_$DATE.tar.gz"

log() {
    local LEVEL="$1"
    local MESSAGE="$2"
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [$LEVEL] $MESSAGE" >> "$LOG_FILE"
}

mkdir -p "$LOG_DIR"
mkdir -p "$BACKUP_DIR"

log "INFO" "Rozpoczynam backup..."

cd "$(dirname "$SOURCE_DIR")"

if tar --exclude='./backup' -czf "$BACKUP_DIR/$FILENAME" "$(basename "$SOURCE_DIR")" 2>> "$LOG_FILE"; then
    log "INFO" "Backup zakończony sukcesem: $FILENAME"
else
    log "ERROR" "Backup NIE POWIÓDŁ SIĘ! Sprawdź miejsce na dysku lub uprawnienia."
    exit 1 
fi