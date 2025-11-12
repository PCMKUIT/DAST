#!/usr/bin/env bash
# Example invocation -> scans OWASP Juice Shop container if you want a safe target
# Start Juice Shop in docker (optional)
# docker run --rm -d -p 3000:3000 bkimminich/juice-shop


# Then run scan against http://host.docker.internal:3000 or http://localhost:3000
# Example:
./tools/zap_scan.sh http://host.docker.internal:3000 report/zap_juice_shop.html
