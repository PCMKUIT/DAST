#!/bin/bash

TARGET=$1
OUTPUT=${2:-report/nikto_report.html}

if [ -z "$TARGET" ]; then
    echo "Usage: $0 <TARGET_URL> [OUTPUT_HTML_FILE]"
    exit 2
fi

echo "Starting Nikto scan for: $TARGET"
echo "Output: $OUTPUT"

mkdir -p "$(dirname "$OUTPUT")"

# 1. Try pulling prebuilt image
NIKTO_IMAGE="sullo/nikto"
echo "Trying to pull $NIKTO_IMAGE..."
if ! docker pull $NIKTO_IMAGE >/dev/null 2>&1; then
    echo "Pull failed. Building custom Nikto image locally..."

    cat > Dockerfile.nikto <<'EOF'
FROM perl:5.36-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends git ca-certificates libwww-perl liblwp-protocol-https-perl && \
    git clone https://github.com/sullo/nikto.git /opt/nikto && \
    ln -s /opt/nikto/program/nikto.pl /usr/local/bin/nikto && \
    chmod +x /usr/local/bin/nikto && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/nikto
ENTRYPOINT ["perl", "/opt/nikto/program/nikto.pl"]
EOF

    docker build -t local/nikto -f Dockerfile.nikto .
    NIKTO_IMAGE="local/nikto"
fi

# 2. Run scan
echo "Running Nikto scan using image: $NIKTO_IMAGE"
docker run --rm -v "$(pwd)":/tmp "$NIKTO_IMAGE" \
    -h "$TARGET" \
    -o "/tmp/$OUTPUT" \
    -Format htm

# 3. Check report
if [ -f "$OUTPUT" ]; then
    echo "Nikto scan completed successfully!"
    echo "Report saved at: $OUTPUT"
else
    echo "No report found — writing empty report placeholder."
     echo "<html><body><h1>Nikto Scan</h1><p>No findings or scan failed</p></body></html>" > "$OUTPUT"
fi
