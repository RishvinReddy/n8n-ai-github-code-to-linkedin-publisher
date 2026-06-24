#!/bin/bash

# A simple script to test the n8n GitHub workflow locally without pushing code
# Replace this URL with your actual n8n Test Webhook URL
WEBHOOK_URL="http://localhost:5678/webhook-test/your-webhook-id"

echo "Sending mock GitHub push event to: $WEBHOOK_URL"
echo "------------------------------------------------"

curl -X POST "$WEBHOOK_URL" \
     -H "Content-Type: application/json" \
     -H "X-GitHub-Event: push" \
     -d @mock-github-webhook.json

echo -e "\n\nDone! Check your n8n canvas."
