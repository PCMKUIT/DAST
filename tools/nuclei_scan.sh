#!/bin/bash

TARGET=$1
OUTPUT=${2:-report/nuclei_report.json}

if [ -z "$TARGET" ]; then
    echo "Usage: $0 <TARGET_URL> [OUTPUT_JSON_FILE]"
    exit 2
fi

echo "Starting Nuclei scan for: $TARGET"
echo "Output: $OUTPUT"

mkdir -p "$(dirname "$OUTPUT")"

NUCLEI_IMAGE="projectdiscovery/nuclei:latest"
echo "Pulling Nuclei Docker image..."
if ! docker pull $NUCLEI_IMAGE >/dev/null 2>&1; then
    echo "Failed to pull Nuclei image. Exiting."
    exit 1
fi

echo "Running Nuclei scan..."
docker run --rm -v "$(pwd)":/nuclei "$NUCLEI_IMAGE" \
  -u "$TARGET" \
  -o "/nuclei/$OUTPUT" \
  -j

if [ -f "$OUTPUT" ]; then
    echo "Nuclei scan completed: $OUTPUT"
else
    echo "No report generated, creating placeholder."
    echo "[]" > "$OUTPUT"
fi
