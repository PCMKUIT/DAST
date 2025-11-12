# DAST Automation


Automated Dynamic Application Security Testing (DAST) scaffold using OWASP ZAP (docker). This repo provides:


- `tools/zap_scan.sh`: a helper script that runs OWASP ZAP docker scan against a target URL and outputs an HTML report.
- GitHub Actions workflow `.github/workflows/dast.yml` to run a ZAP scan on push/PR (change `TARGET_URL` to your target or use repository secrets).
- `report/` folder for storing generated HTML/summary reports.


## Quick start (local)


1. Ensure Docker is installed and you can run containers.


2. Edit `tools/zap_scan.sh` if you want to customize scan options.


3. Run a baseline scan:


```bash
bash tools/zap_scan.sh https://example.com report/zap_report.html
