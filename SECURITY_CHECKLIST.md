# Web Application Security Checklist (DAST)
*Based on OWASP Top 10 - 2021*

**Usage:**  
- Use this checklist when performing **dynamic application security testing** (DAST) on staging or test environments.  
- Run scans using **OWASP ZAP**, **Burp Suite**, or equivalent.  
- Do **not** scan production without explicit authorization.  
- P0 = Critical, P1 = High, P2 = Medium, P3 = Low.

---

## Pre-Scan Setup
- [ ] Define target URLs / scope (avoid external or sensitive domains) (P0)  
- [ ] Ensure test credentials are available for authenticated scans (P1)  
- [ ] Use Dockerized or isolated environment for OWASP ZAP (P1)  
- [ ] Backup or clone data if needed; no live customer data (P0)  
- [ ] Configure ZAP scan mode (passive vs. active) (P1)  

---

## A01 — Broken Access Control
**Goal:** Detect unauthorized access and privilege escalation at runtime.  

**Checklist**
- [ ] Test all sensitive endpoints with different roles/users (P0)  
- [ ] Attempt to access admin-only URLs as normal user (P0)  
- [ ] Modify object IDs in requests (test IDOR) (P0)  
- [ ] Check rate limits for sensitive functions (P1)

---

## A02 — Cryptographic Failures
**Goal:** Identify weak or missing encryption in transport/data.  

**Checklist**
- [ ] Verify HTTPS enforced (redirects, HSTS headers) (P0)  
- [ ] Check for weak cipher suites using ZAP/Burp plugins (P1)  
- [ ] Scan for missing `Secure`/`HttpOnly` cookies (P0)  
- [ ] Validate sensitive data not transmitted in plain text (P0)

---

## A03 — Injection
**Goal:** Identify runtime injection vulnerabilities.  

**Checklist**
- [ ] Use ZAP active scan injection tests (P0)  
- [ ] Attempt SQL/NoSQL/Command injection payloads (P0)  
- [ ] Test input fields, headers, parameters, cookies (P0)  
- [ ] Observe app behavior for stack traces or unexpected responses (P0)

---

## A05 — Security Misconfiguration
**Goal:** Detect insecure server or application configurations.  

**Checklist**
- [ ] Check for exposed admin panels / debug pages (P0)  
- [ ] Identify missing security headers (CSP, X-Frame-Options, etc.) (P1)  
- [ ] Test CORS configuration (no `*` with credentials) (P0)  
- [ ] Detect directory listing, verbose errors, or default pages (P1)

---

## A06 — Vulnerable and Outdated Components
**Goal:** Verify that deployed system does not expose vulnerable components.  

**Checklist**
- [ ] Check version banners in headers / error pages (P1)  
- [ ] Cross-check known CVEs using ZAP plugin or manual review (P1)  
- [ ] Ensure 3rd-party scripts/libraries are loaded via HTTPS (P1)

---

## A07 — Identification and Authentication Failures
**Goal:** Identify weaknesses in login, sessions, and tokens.  

**Checklist**
- [ ] Check session cookie flags (`Secure`, `HttpOnly`, `SameSite`) (P0)  
- [ ] Test weak login / brute-force / lockout (P1)  
- [ ] Attempt to reuse session tokens after logout (P0)  
- [ ] Inspect password reset / MFA flows for bypasses (P1)

---

## A09 — Security Logging and Monitoring Failures
**Goal:** Ensure attacks generate visible, auditable logs.  

**Checklist**
- [ ] Trigger known attack patterns and confirm log entries (P1)  
- [ ] Check error responses for generic vs. detailed messages (P1)  
- [ ] Validate alerting system for anomalies (P2)

---

## A10 — SSRF
**Goal:** Detect SSRF via runtime payloads.  

**Checklist**
- [ ] Test URL upload/fetch fields with internal IPs / metadata endpoints (P0)  
- [ ] Check responses/timeouts for blind SSRF indicators (P0)  

---

## Post-Scan Review
- [ ] Review ZAP/Burp HTML report for false positives (P1)  
- [ ] Document confirmed vulnerabilities with evidence (P1)  
- [ ] Prioritize fixes based on impact (P0)  
- [ ] Re-run targeted scans after remediation (P1)

---

## Recommended Tools
- **DAST:** OWASP ZAP, Burp Suite  
- **CI/CD integration:** GitHub Actions, ZAP Docker baseline/full scan  
- **Supporting tools:** nmap, Nikto, SSLyze, Wfuzz  
- **Reporting:** ZAP HTML report, markdown summary for PRs  

---

**Note:** Always test within authorized scope. Misuse may lead to legal consequences.
