#!/bin/bash
CONFIG_FILE="config.json"

# Check if file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: $CONFIG_FILE not found."
    exit 1
fi

# Use -r to get raw strings instead of quoted strings
DB_HOST=$(jq -r '.database.host' "$CONFIG_FILE")
DB_PORT=$(jq -r '.database.port' "$CONFIG_FILE")
DB_USER=$(jq -r '.database.credentials.user' "$CONFIG_FILE")
DB_PASSWD=$(jq -r '.database.credentials.password' "$CONFIG_FILE")

echo "Connecting to database at ${DB_HOST}:${DB_PORT} as user '${DB_USER}' password '${DB_PASSWD}'"

