# DAST PR Checklist


Before merging, ensure the following if this change affects runtime endpoints or environment:


- [ ] Confirm DAST scans are run on staging environment.
- [ ] No production URL used in CI or scan workflows.
- [ ] Any new external integrations are reviewed for SSRF/SSO risks.
- [ ] Add tests or monitoring for changed endpoints.
- [ ] Attach DAST scan report if relevant.
