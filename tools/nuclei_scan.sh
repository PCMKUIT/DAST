#!/bin/bash

TARGET=$1
OUTPUT=${2:-report/nuclei_scan.html}

if [ -z "$TARGET" ]; then
    echo "Usage: $0 <TARGET_URL> [OUTPUT_HTML_FILE]"
    exit 2
fi

echo "Starting Nuclei scan for: $TARGET"
echo "Output: $OUTPUT"

# Ensure directories exist
mkdir -p "$(dirname "$OUTPUT")"
mkdir -p "nuclei-templates"

# Pull latest Nuclei image
echo "Pulling Nuclei Docker image..."
docker pull projectdiscovery/nuclei:latest

# Update templates chỉ khi cần (1 lần đầu)
if [ ! -f "nuclei-templates/.updated" ]; then
    echo "First time setup: Updating Nuclei templates..."
    docker run --rm \
      -v "$(pwd)/nuclei-templates:/root/nuclei-templates" \
      projectdiscovery/nuclei:latest \
      -update-templates
    touch "nuclei-templates/.updated"
    echo "Templates updated successfully!"
else
    echo "Using cached templates"
fi

# Run Nuclei scan với HTML output
echo "Running Nuclei scan with HTML report..."
docker run --rm \
  -v "$(pwd)":/nuclei \
  -v "$(pwd)/nuclei-templates:/root/nuclei-templates" \
  projectdiscovery/nuclei:latest \
  -u "$TARGET" \
  -o "/nuclei/$OUTPUT" \
  -me "/nuclei/$OUTPUT" \
  -severity high,critical \
  -timeout 120

if [ -f "$OUTPUT" ]; then
    echo "Nuclei scan completed successfully!"
    echo "HTML Report saved at: $OUTPUT"
else
    echo "Scan finished but output file not found!"
    exit 1
fi
