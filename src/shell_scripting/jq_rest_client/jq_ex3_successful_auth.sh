#!/bin/bash

API_URL="https://httpbin.org"
TOKEN="secret_token_abc123"

# Send an HTTP GET request with an Authorization header
response=$(curl -s -H "Authorization: Bearer $TOKEN" "$API_URL")

# Use jq to extract data, providing safety defaults if keys are missing
authenticated=$(echo "$response" | jq -r '.authenticated')
token_received=$(echo "$response" | jq -r '.token')

if [ "$authenticated" = "true" ]; then
    echo "Success! API authenticated your token: $token_received"
else
    echo "Authentication failed."
fi

