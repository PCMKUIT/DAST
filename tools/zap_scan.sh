#!/usr/bin/env bash
# Simple wrapper to run OWASP ZAP docker full scan and save report
# Usage: ./tools/zap_scan.sh <TARGET_URL> <OUTPUT_HTML>


set -euo pipefail


TARGET_URL=${1:-}
OUTPUT_HTML=${2:-report/zap_report.html}


if [[ -z "$TARGET_URL" ]]; then
echo "Usage: $0 <TARGET_URL> [OUTPUT_HTML]"
exit 2
fi


# Pull latest stable ZAP docker image
docker pull owasp/zap2docker-stable:latest


# Run zap-full-scan.py inside container (active scan)
# -t target URL
# -r report file inside container
# We'll bind mount current directory so report is saved to host


docker run --rm -v "$(pwd)":/zap/wrk/:rw -t owasp/zap2docker-stable:latest \
zap-full-scan.py -t "$TARGET_URL" -r "/zap/wrk/$OUTPUT_HTML" --self-contained


if [[ -f "$OUTPUT_HTML" ]]; then
echo "Report generated: $OUTPUT_HTML"
else
echo "Scan finished but report not found at $OUTPUT_HTML"
exit 1
fi
