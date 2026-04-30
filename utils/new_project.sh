#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"

if [ -z "${1:-}" ]; then
    echo "Użycie: $0 <nazwa_projektu>"
    exit 1
fi

PROJECT_NAME=$1
PROJECT_PATH="$BASE_DIR/$PROJECT_NAME"

if [ -d "$PROJECT_PATH" ]; then
    echo "BŁĄD: Folder '$PROJECT_NAME' już istnieje w $BASE_DIR!"
    exit 1
fi

echo "Tworzę strukturę dla: $PROJECT_NAME w katalogu głównym ($BASE_DIR)..."

mkdir -p "$PROJECT_PATH"/{backup,install,logs,utils}

echo "# $PROJECT_NAME" > "$PROJECT_PATH/README.md"
echo "logs/" > "$PROJECT_PATH/.gitignore"
echo "backup/" >> "$PROJECT_PATH/.gitignore"

cd "$PROJECT_PATH"
git init > /dev/null

echo "Gotowe! Projekt '$PROJECT_NAME' czeka w folderze '$PROJECT_PATH'."