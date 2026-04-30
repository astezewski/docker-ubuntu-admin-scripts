#!/bin/bash
set -euo pipefail

if [ -z "${1:-}" ]; then
    echo "Użycie: $0 <nazwa_projektu>"
    exit 1
fi

PROJECT_NAME=$1

if [ -d "$PROJECT_NAME" ]; then
    echo "BŁĄD: Folder '$PROJECT_NAME' już istnieje!"
    exit 1
fi

echo "Tworzę strukturę dla: $PROJECT_NAME..."

mkdir -p "$PROJECT_NAME"/{backup,install,logs,utils}

echo "# $PROJECT_NAME" > "$PROJECT_NAME/README.md"
echo "logs/" > "$PROJECT_NAME/.gitignore"
echo "backup/" >> "$PROJECT_NAME/.gitignore"

cd "$PROJECT_NAME"
git init > /dev/null

echo "Gotowe! Projekt '$PROJECT_NAME' czeka w folderze '$PROJECT_NAME'."