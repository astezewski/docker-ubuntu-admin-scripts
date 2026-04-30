#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"

USER_LOGGED="${USER:-$(whoami)}"
USER_DIR="$BASE_DIR/users/${USER_LOGGED}"

if [ -d "$USER_DIR" ]; then
    echo "Folder użytkownika $USER_LOGGED już istnieje"
else 
    mkdir -p "$USER_DIR"
    echo "Utworzono folder $USER_LOGGED w ścieżce: $USER_DIR"
fi