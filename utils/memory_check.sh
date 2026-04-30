#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"

LOG_DIR="$BASE_DIR/logs"
LOG_FILE="$LOG_DIR/system.log"
THRESHOLD=80
CURRENT_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//g')

mkdir -p "$LOG_DIR"

log() {
    local LEVEL="$1"
    local MESSAGE="$2"
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [$LEVEL] $MESSAGE" >> "$LOG_FILE"
}

log "INFO" "Rozpoczynam procedurę weryfikacji miejsca na dysku"

if [ "$CURRENT_USAGE" -gt "$THRESHOLD" ]; then
    log "ERROR" "UWAGA: Miejsce na dysku przekracza ${THRESHOLD}%! Aktualnie wynosi: ${CURRENT_USAGE}%"
else
    log "INFO" "Stan dysku w normie: ${CURRENT_USAGE}%"
fi