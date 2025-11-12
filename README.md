# DAST Automation

Automated Dynamic Application Security Testing (DAST) scaffold using **OWASP ZAP (Docker)**. This repo provides:

* `tools/zap_scan.sh`: a helper script that runs OWASP ZAP docker scan against a target URL and outputs an HTML report.
* GitHub Actions workflow `.github/workflows/dast.yml` to run a ZAP scan on push/PR (change `TARGET_URL` to your target or use repository secrets).
* `report/` folder for storing generated HTML/summary reports.

---

## 🧰 Quick Start (Local)

### 🐧 For Ubuntu / Linux

1. Ensure **Docker** is installed and you can run containers without `sudo`.
2. Edit `tools/zap_scan.sh` if you want to customize scan options.
3. Run a baseline scan:

   ```bash
   bash tools/zap_scan.sh https://example.com report/zap_report.html
   ```
4. Open `report/zap_report.html` in a browser after the run completes.

### 🪟 For Windows

If you're using Windows, you’ll need to set up a Linux-like environment:

1. **Install [WSL 2](https://learn.microsoft.com/en-us/windows/wsl/install)** (Windows Subsystem for Linux) and open Ubuntu from WSL.
2. **Install [Docker Desktop](https://www.docker.com/products/docker-desktop/)** and ensure it’s integrated with WSL.
3. Clone this repo inside your WSL filesystem (e.g. `/home/user/DAST-Automation`).
4. Run the same command as Linux:

   ```bash
   bash tools/zap_scan.sh https://example.com report/zap_report.html
   ```
5. Access the report via your Windows file explorer or from WSL path: `\wsl$\Ubuntu\home\user\DAST-Automation\report\zap_report.html`

> ⚠️ **Note:** Running Docker directly from Windows Command Prompt or PowerShell won’t work with these scripts — you must use **WSL Bash**.

---

## ⚙️ CI (GitHub Actions)

The workflow `.github/workflows/dast.yml` demonstrates running ZAP in CI. Configure a repository variable or secret `TARGET_URL` to point to your staging site (never run against production without permission).

---

## 🧩 Notes & Safety

* **DO NOT** run active scans against production systems without explicit written permission.
* Use a staging environment or a deliberately vulnerable app (DVWA, Juice Shop) for testing.

---

## 📄 License

MIT
