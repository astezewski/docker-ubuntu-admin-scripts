#!/bin/bash

USER_LOGGED=$USER
USER_DIR="$HOME/scripts/users/${USER_LOGGED}"

if [ -d "$USER_DIR" ]; then
    echo "Folder użytkownika już istnieje"
else 
    mkdir -p "$USER_DIR"
    echo "Utworzono folder $USER_LOGGED"
fi


