#!/bin/bash


set -euo pipefail

LOG_DIR="$HOME/scripts/logs"
LOG_FILE="$LOG_DIR/system.log"
THRESHOLD=80
CURRENT_USAGE=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')


log() {
    local LEVEL="$1"
    local MESSAGE="$2"
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [$LEVEL] $MESSAGE" >> "$LOG_FILE"
}




log "INFO" "Rozpoczynam procedurę weryfikacji danych"

if [ "$CURRENT_USAGE" -gt "$THRESHOLD" ]; then
    log "ERROR" "UWAGA: Miejsce na dysku przekracza ${THRESHOLD}%! Aktualnie wynosi: ${CURRENT_USAGE}%"
    
else
    log "INFO" "Stan dysku w normie,: ${CURRENT_USAGE}%"
fi