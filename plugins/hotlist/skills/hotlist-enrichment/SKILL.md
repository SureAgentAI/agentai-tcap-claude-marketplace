---
name: hotlist-enrichment
description: Run data enrichment for the Hot List Dashboard — employee counts, open roles, news mentions
---

# Hot List Enrichment

This skill runs data enrichment scripts against the Hot List Dashboard's SQLite database, updating company records with fresh signals from external APIs.

The dashboard tracks 34 private healthcare companies for Transform Capital. Enrichment pulls employee counts, open job roles, and press mentions to feed the composite ranking algorithm.

---

## Prerequisites

### API Keys (configured as env vars in the production container)

| Key | Source | Free Tier |
|-----|--------|-----------|
| `PDL_API_KEY` | [People Data Labs](https://peopledatalabs.com) | 100 requests/month |
| `NEWSDATA_API_KEY` | [Newsdata.io](https://newsdata.io) | 200 credits/day |

The jobs enrichment does NOT require an API key (it scrapes public job boards).

### Python Dependencies (pre-installed in the production container)

- Python 3.10+ (production uses 3.11)
- `python-jobspy` — job board scraper for Indeed and LinkedIn
- `openpyxl` — Excel support (dependency of jobspy)
- `requests` — HTTP client (standard library `urllib` is also used)

---

## Production Environment

Enrichment scripts run inside the Docker container on Coolify (AWS EC2). You must SSH into the server and exec into the container.

### Connecting to the container

```bash
ssh agentaibiz
sudo docker exec -it $(sudo docker ps --filter name=t804g4cossow44g80oscc48k -q) bash
```

Once inside the container, scripts are at `scripts/` and the database is at `data/hotlist.db`.

---

## Enrichment Types

### 1. PDL (People Data Labs) — Employee Counts + Websites

**What it does:** Queries the PDL company enrichment API for each company, updating `employees` and `website` fields.

**API:** `GET https://api.peopledatalabs.com/v5/company/enrich`

**Command:**
```bash
python3 scripts/enrich-pdl.py --db data/hotlist.db
```

**Expected output:**
```
PDL Enrichment: 34 companies to process
--------------------------------------------------
Enriching 1/34: CompanyName... OK (employees=150, website=https://example.com)
Enriching 2/34: AnotherCo... OK (employees=85, website=None)
...
--------------------------------------------------
PDL Enrichment complete: 27 updated, 0 errors out of 34
```

**Rate limit:** 1 request per second (built into the script). Full run takes ~35 seconds.

**Free tier note:** PDL gives 100 requests/month on the free plan. Running enrichment for all 34 companies uses 34 credits. You can run ~2-3 full enrichments per month.

---

### 2. Jobs — Open Roles via python-jobspy

**What it does:** Scrapes Indeed and LinkedIn for open job postings matching each company name. Updates the `open_roles` count.

**No API key required.** Uses python-jobspy to scrape public job listings.

**Command:**
```bash
python3 scripts/enrich-jobs.py --db data/hotlist.db
```

**Expected output:**
```
Jobs Enrichment: 34 companies to process
--------------------------------------------------
Enriching 1/34: CompanyName... OK (12 open roles)
Enriching 2/34: AnotherCo... OK (3 open roles)
...
--------------------------------------------------
Jobs Enrichment complete: 34 updated, 0 errors out of 34
```

**Rate limit:** 3 seconds between companies (polite to job sites). Full run takes ~2 minutes.

**Note:** Job board scrapers can be flaky. If Indeed or LinkedIn block requests, the script will log errors but continue processing remaining companies. Re-run after a few hours if you see many failures.

---

### 3. News — Press Mentions via Newsdata.io

**What it does:** Searches for recent news articles mentioning each company (combined with "healthcare" to reduce false positives). Updates `press_mentions_6mo`, `latest_press_title`, and `latest_press_url`.

**API:** `GET https://newsdata.io/api/1/news`

**Command:**
```bash
python3 scripts/enrich-news.py --db data/hotlist.db
```

**Expected output:**
```
News Enrichment: 34 companies to process
--------------------------------------------------
Enriching 1/34: CompanyName... OK (5 mentions)
Enriching 2/34: AnotherCo... OK (0 mentions)
...
--------------------------------------------------
News Enrichment complete: 34 updated, 0 errors out of 34
```

**Rate limit:** 1 request per second (built into the script). Full run takes ~35 seconds.

**Free tier note:** Newsdata.io gives 200 credits/day. Each company search uses 1 credit. You can run this ~5 times per day.

---

## Running All Enrichments

To run all enrichment scripts sequentially:

```bash
bash scripts/enrich-all.sh
```

Or manually in order:
```bash
python3 scripts/enrich-pdl.py --db data/hotlist.db
python3 scripts/enrich-jobs.py --db data/hotlist.db
python3 scripts/enrich-news.py --db data/hotlist.db
```

**Total time for a full run:** approximately 3-4 minutes.

---

## Verification

After running enrichment, verify the results are reflected in the dashboard:

### 1. Check the API directly

```bash
curl -s https://hotlist.agentai.biz/api/companies | python3 -c "
import json, sys
data = json.load(sys.stdin)
companies = data if isinstance(data, list) else data.get('companies', data.get('data', []))
for c in companies[:5]:
    print(f\"{c.get('name', 'N/A'):30s} employees={c.get('employees', 'N/A'):>6s}  roles={c.get('open_roles', 'N/A'):>4s}  press={c.get('press_mentions_6mo', 'N/A'):>4s}\")
print(f'... ({len(companies)} total)')
"
```

### 2. Check enrichment logs inside the container

```bash
sqlite3 data/hotlist.db "SELECT source, companies_updated, status, created_at FROM enrichment_log ORDER BY created_at DESC LIMIT 10;"
```

### 3. Visual verification

Open https://hotlist.agentai.biz in a browser and confirm:
- Employee count column is populated
- Open roles column shows numbers (not all zeros)
- Press mentions column has data
- Composite score rankings have shifted based on new data

---

## Additional Enrichment Scripts (Limited Availability)

These scripts exist but have known limitations:

| Script | Status | Issue |
|--------|--------|-------|
| `enrich-crunchbase.py` | Needs API key | Crunchbase requires a separate paid API key (not yet provisioned) |
| `enrich-traffic.py` | Blocked | SimilarWeb API returns 403 errors; needs official API tier or alternative provider |

---

## Known Limitations

1. **SimilarWeb traffic data returns 403.** The free/unofficial API endpoint is blocked. Website traffic signals are not available until we get official API access or switch to an alternative provider.

2. **Employee growth requires historical snapshots.** The `employees` field captures a point-in-time count. To compute 12-month headcount growth, enrichment must be run periodically (e.g., monthly) to build a historical baseline. There is no growth data until at least two snapshots exist.

3. **Crunchbase needs a separate API key.** The `enrich-crunchbase.py` script is ready but requires a Crunchbase Basic API key ($499/year). Current funding data was loaded from the seed SQL file and may become stale.

4. **Job scraping can be unreliable.** Indeed and LinkedIn may throttle or block scraping. Results vary by time of day and IP reputation. The script uses a 3-second delay between requests to be polite, but failures can still occur.

5. **News search adds "healthcare" qualifier.** To reduce false positives for companies with generic names, the news search appends "healthcare" to every query. This may miss relevant articles that do not mention healthcare explicitly.
