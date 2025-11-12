#!/bin/bash

TARGET_URL=$1
OUTPUT_HTML=${2:-report/zap_report.html}

if [ -z "$TARGET_URL" ]; then
    echo "Usage: $0 <TARGET_URL> [OUTPUT_HTML]"
    exit 2
fi

echo "Starting ZAP scan for: $TARGET_URL"
echo "Output: $OUTPUT_HTML"

# Ensure output directory exists
mkdir -p "$(dirname "$OUTPUT_HTML")"

echo "Pulling ZAP Docker image..."
docker pull ghcr.io/zaproxy/zaproxy:stable

echo "Running ZAP scan..."
docker run --rm -v "$(pwd)":/zap/wrk/:rw -t ghcr.io/zaproxy/zaproxy:stable \
    zap-full-scan.py -t "$TARGET_URL" -r "/zap/wrk/$OUTPUT_HTML" -I

if [ -f "$OUTPUT_HTML" ]; then
    echo "Report generated: $OUTPUT_HTML"
    echo "Open the report to see security findings!"
else
    echo "Scan finished but report not found!"
    exit 1
fi
