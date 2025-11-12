#!/bin/bash

TARGET=$1
OUTPUT=${2:-report/nuclei_report.json}

if [ -z "$TARGET" ]; then
    echo "Usage: $0 <TARGET_URL> [OUTPUT_JSON_FILE]"
    exit 2
fi

echo "Starting Nuclei scan for: $TARGET"
echo "Output: $OUTPUT"

# Ensure directories exist
mkdir -p "$(dirname "$OUTPUT")"
mkdir -p "nuclei-templates"

# Pull latest Nuclei Docker image
echo "Pulling Nuclei Docker image..."
docker pull projectdiscovery/nuclei:latest

# Update templates if needed
if [ ! -f "nuclei-templates/.updated" ]; then
    echo "First time setup: Updating Nuclei templates..."
    docker run --rm \
      -v "$(pwd)/nuclei-templates:/root/nuclei-templates" \
      projectdiscovery/nuclei:latest \
      -ut
    touch "nuclei-templates/.updated"
    echo "Templates updated successfully!"
else
    echo "Using cached templates"
fi

# Run Nuclei scan (JSON output)
echo "Running Nuclei scan..."
docker run --rm \
  -v "$(pwd)":/nuclei \
  -v "$(pwd)/nuclei-templates:/root/nuclei-templates" \
  projectdiscovery/nuclei:latest \
  -u "$TARGET" \
  -o "/nuclei/$OUTPUT" \
  -json \
  -severity medium,high,critical \
  -timeout 120 \
  -stats

# Check result
if [ -s "$OUTPUT" ]; then
    echo "Nuclei scan completed successfully!"
    echo "JSON Report saved at: $OUTPUT"
else
    echo "Scan finished but output file not found or empty!"
    exit 1
fi
