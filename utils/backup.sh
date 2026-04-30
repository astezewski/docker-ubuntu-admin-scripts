#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"

SOURCE_DIR="$BASE_DIR"
BACKUP_DIR="$BASE_DIR/backup"
LOG_DIR="$BASE_DIR/logs"
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