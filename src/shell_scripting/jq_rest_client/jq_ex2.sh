#!/bin/bash

# Fetch a list of dummy users from a public API
API_URL="https://typicode.com"
response=$(curl -s "$API_URL")

# Check if curl command succeeded
if [ -z "$response" ]; then
    echo "Failed to fetch data."
    exit 1
fi

# Parse the array and print a formatted summary
# .[] iterates through the array elements
echo "$response" | jq -c '.[]' | while read -r user; do
    name=$(echo "$user" | jq -r '.name')
    email=$(echo "$user" | jq -r '.email')
    company=$(echo "$user" | jq -r '.company.name')
    
    echo "User: $name | Email: $email | Company: $company"
done

