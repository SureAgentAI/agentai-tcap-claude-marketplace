---
name: hotlist
description: Hot List Dashboard — view status, run enrichment, export data
argument-hint: [enrich|export|status]
---

# Hot List Dashboard

The Hot List Dashboard ranks 34 private healthcare companies by growth signals for Transform Capital's Monday pipeline meetings.

**Dashboard:** https://hotlist.agentai.biz
**API:** https://hotlist.agentai.biz/api/companies

---

## Routing

Parse the user's arguments and route accordingly:

### No arguments or `status`

Display a summary of the dashboard:

1. Fetch `https://hotlist.agentai.biz/api/companies` to get current data
2. Report:
   - Total companies tracked
   - Number with employee counts, funding data, press mentions, open roles
   - Link to the live dashboard: https://hotlist.agentai.biz
   - When enrichment was last run (check `enriched_at` timestamps)
3. List available actions:
   - `/hotlist enrich` — run data enrichment (employee counts, jobs, news)
   - `/hotlist export` — export ranked company list as CSV

### `enrich`

Invoke the `hotlist-enrichment` skill to run data enrichment against the production database. This skill covers all three enrichment types (PDL, Jobs, News) and walks through prerequisites, execution, and verification.

### `export`

Guide the user through exporting the ranked company list:

1. Fetch data from the API:
   ```bash
   curl -s https://hotlist.agentai.biz/api/companies | python3 -m json.tool
   ```

2. The dashboard UI has a built-in CSV export button — direct the user to https://hotlist.agentai.biz and click the "Export CSV" button in the top-right corner.

3. For programmatic export, the API response can be converted to CSV:
   ```bash
   curl -s https://hotlist.agentai.biz/api/companies | python3 -c "
   import json, csv, sys
   data = json.load(sys.stdin)
   companies = data if isinstance(data, list) else data.get('companies', data.get('data', []))
   if not companies:
       print('No data returned from API', file=sys.stderr)
       sys.exit(1)
   writer = csv.DictWriter(sys.stdout, fieldnames=companies[0].keys())
   writer.writeheader()
   writer.writerows(companies)
   " > hotlist-export.csv
   ```

4. Confirm the export file was created and report the row count.
