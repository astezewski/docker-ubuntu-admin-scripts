#!/bin/bash
set -euo pipefail

LISTA_APPS="apps.txt"
LOG_DIR="../logs"
LOG_FILE="$LOG_DIR/install_$(date +%Y-%m-%d).log"

# 1. Przygotowanie logów
mkdir -p "$LOG_DIR"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

if [[ ! -f "$LISTA_APPS" ]]; then
    log "BŁĄD: Plik $LISTA_APPS nie istnieje!"
    exit 1
fi

log "Start procesu instalacji. Logi zapisywane w: $LOG_FILE"

while IFS= read -r pkg || [[ -n "$pkg" ]]; do
    [[ "$pkg" =~ ^#.*$ ]] && continue
    [[ -z "$pkg" ]] && continue

    if command -v "$pkg" &> /dev/null; then
        log "INFO: $pkg jest już zainstalowany. Pomijam."
    else
        log "INFO: Instaluję $pkg..."
        if sudo apt install -y "$pkg" 2>&1 | sudo tee -a "$LOG_FILE" > /dev/null; then
            log "SUKCES: $pkg zainstalowany pomyślnie."
        else
            log "BŁĄD: Nie udało się zainstalować $pkg. Sprawdź logi powyżej."
        fi
    fi
done < "$LISTA_APPS"

log "Proces instalacji zakończony."t i