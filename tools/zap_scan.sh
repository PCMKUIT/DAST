#!/usr/bin/env bash
set -euo pipefail

TARGET_URL=${1:-}
OUTPUT_HTML=${2:-report/zap_report.html}

if [[ -z "$TARGET_URL" ]]; then
  echo "Usage: $0 <TARGET_URL> [OUTPUT_HTML]"
  exit 2
fi

echo "Starting ZAP scan for: $TARGET_URL"
echo "Output: $OUTPUT_HTML"

# Ensure output directory exists
mkdir -p "$(dirname "$OUTPUT_HTML")"

docker pull owasp/zap2docker-stable:latest

docker run --rm -v "$(pwd)":/zap/wrk/:rw -t owasp/zap2docker-stable:latest \
  zap-full-scan.py -t "$TARGET_URL" -g gen.conf -r "/zap/wrk/$OUTPUT_html" -I
