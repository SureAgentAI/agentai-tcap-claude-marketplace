---
name: workspace-setup
description: Step-by-step guide to set up Google Workspace and Outlook integration
---

# Workspace MCP Setup Guide

This skill walks you through setting up Google Workspace (Gmail, Calendar, Drive, Docs, Sheets, Slides) integration via the `google-workspace-mcp` server.

---

## Phase 1: Google Cloud Project Setup

### 1.1 Create a Google Cloud Project

1. Go to [console.cloud.google.com](https://console.cloud.google.com/)
2. Click the project dropdown at the top of the page
3. Click **New Project**
4. Name it something like "Claude Workspace MCP"
5. Click **Create**
6. Make sure the new project is selected in the dropdown

### 1.2 Enable Required APIs

Navigate to **APIs & Services > Library** and enable each of these:

| API | Search Term |
|-----|-------------|
| Gmail API | `gmail` |
| Google Calendar API | `calendar` |
| Google Drive API | `drive` |
| Google Docs API | `docs` |
| Google Sheets API | `sheets` |
| Google Slides API | `slides` |

For each API: click on it, then click **Enable**.

### 1.3 Configure OAuth Consent Screen

1. Go to **APIs & Services > OAuth consent screen**
2. Select **External** user type (unless you have a Google Workspace org, then use Internal)
3. Click **Create**
4. Fill in the required fields:
   - **App name**: "Claude Workspace MCP"
   - **User support email**: your email
   - **Developer contact email**: your email
5. Click **Save and Continue**
6. On the **Scopes** page, click **Add or Remove Scopes** and add:
   - `https://www.googleapis.com/auth/gmail.modify`
   - `https://www.googleapis.com/auth/calendar`
   - `https://www.googleapis.com/auth/drive`
   - `https://www.googleapis.com/auth/documents`
   - `https://www.googleapis.com/auth/spreadsheets`
   - `https://www.googleapis.com/auth/presentations`
7. Click **Save and Continue** through remaining steps
8. If using External type, add your Google account as a **Test user**

### 1.4 Create OAuth 2.0 Credentials

1. Go to **APIs & Services > Credentials**
2. Click **Create Credentials > OAuth client ID**
3. Application type: **Desktop application**
4. Name: "Claude Workspace MCP"
5. Click **Create**
6. Note the **Client ID** and **Client Secret** (you will need these next)

---

## Phase 2: Configure Credentials

### 2.1 Download Credentials File

1. On the OAuth client you just created, click the download icon to get the JSON
2. Create the config directory:
   ```bash
   mkdir -p ~/.google-mcp
   ```
3. Move the downloaded file:
   ```bash
   mv ~/Downloads/client_secret_*.json ~/.google-mcp/credentials.json
   ```

### 2.2 Set Environment Variables

Add these to your shell profile (`~/.zshrc`, `~/.bashrc`, or equivalent):

```bash
export GOOGLE_OAUTH_CLIENT_ID="your-client-id-here.apps.googleusercontent.com"
export GOOGLE_OAUTH_CLIENT_SECRET="your-client-secret-here"
```

Then reload your shell:

```bash
source ~/.zshrc
```

### 2.3 Add Your Google Account

Run the account setup command:

```bash
npx google-workspace-mcp accounts add my-account
```

This will open your browser for OAuth authorization. Grant all requested permissions. The refresh token is stored locally so you only need to do this once.

### 2.4 Verify Account

```bash
npx google-workspace-mcp accounts list
```

You should see your account listed with all permissions granted.

---

## Phase 3: Verify Integration

Once the plugin is enabled, test each service in Claude Code:

### Test Gmail

Ask Claude: "Search my recent emails" or "Show me unread emails from today"

Expected: Claude uses the `search_gmail` or `list_gmail_messages` tool and returns results.

### Test Calendar

Ask Claude: "What meetings do I have today?" or "Show my calendar for this week"

Expected: Claude uses the `list_calendar_events` tool and shows your upcoming events.

### Test Drive

Ask Claude: "List my recent documents" or "Search my Drive for [keyword]"

Expected: Claude uses the `search_drive_files` tool and returns matching files.

### Test Docs/Sheets

Ask Claude: "Read the contents of [document name]" or "Show me the data in [spreadsheet name]"

Expected: Claude fetches and displays document or spreadsheet content.

---

## Troubleshooting

### "OAuth client not found" or "invalid_client"

- Double-check that `GOOGLE_OAUTH_CLIENT_ID` and `GOOGLE_OAUTH_CLIENT_SECRET` match exactly what Google Cloud Console shows
- Make sure you created a **Desktop application** type, not Web application

### "API not enabled" errors

- Go back to **APIs & Services > Library** in Google Cloud Console
- Search for the specific API mentioned in the error
- Click **Enable**

### "Access denied" or "insufficient permissions"

- Make sure your Google account is added as a **Test user** in the OAuth consent screen (if using External type)
- Re-run `npx google-workspace-mcp accounts add my-account` to refresh permissions
- Check that all required scopes were added to the consent screen

### "Quota exceeded" errors

- Google APIs have daily quotas. Gmail: 250 quota units/second, Calendar: 500 requests/100 seconds
- If you hit limits, wait a few minutes and try again
- For heavy usage, request quota increases in Google Cloud Console under **APIs & Services > Quotas**

### "credentials.json not found"

- Ensure the file is at `~/.google-mcp/credentials.json`
- Verify it is the OAuth client JSON (not a service account key)

### MCP server fails to start

- Check that Node.js 18+ is installed: `node --version`
- Try running manually to see errors: `npx google-workspace-mcp serve`
- Check Claude Code logs for MCP connection errors

---

## Optional: Outlook Integration

For Microsoft 365 / Outlook integration, you can add a separate MCP server. This requires a Microsoft Azure app registration.

### Azure App Registration

1. Go to [portal.azure.com](https://portal.azure.com/) > **Azure Active Directory** > **App registrations**
2. Click **New registration**
3. Name: "Claude Outlook MCP"
4. Redirect URI: `http://localhost` (Mobile and desktop applications)
5. Under **API permissions**, add Microsoft Graph permissions:
   - `Mail.Read`, `Mail.Send`
   - `Calendars.Read`, `Calendars.ReadWrite`
   - `Files.Read.All` (for OneDrive)
6. Note the **Application (client) ID** and create a **Client secret**

### Adding to .mcp.json

If a well-maintained Outlook MCP server becomes available on npm, add it to your project's `.mcp.json`:

```json
{
  "outlook": {
    "command": "npx",
    "args": ["-y", "outlook-mcp-server"],
    "env": {
      "MICROSOFT_CLIENT_ID": "{{env.MICROSOFT_CLIENT_ID}}",
      "MICROSOFT_CLIENT_SECRET": "{{env.MICROSOFT_CLIENT_SECRET}}",
      "MICROSOFT_TENANT_ID": "{{env.MICROSOFT_TENANT_ID}}"
    }
  }
}
```

**Note:** Outlook MCP support is experimental. The Google Workspace MCP is mature and recommended for most users. Outlook integration may require additional configuration depending on the MCP server package used.

---

## Read-Only Mode

If you want to prevent any write operations (sending emails, creating events, etc.), set:

```bash
export GOOGLE_MCP_READ_ONLY=true
```

Or pass the flag directly:

```bash
npx google-workspace-mcp serve --read-only
```

This is recommended for initial testing and for shared environments where accidental writes could be problematic.
