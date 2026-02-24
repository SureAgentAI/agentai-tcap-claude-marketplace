---
name: daily-briefing-setup
description: Step-by-step guide to set up the Google Workspace MCP server for daily briefings
---

# Daily Briefing Skill Setup Guide

This guide walks you through setting up the Daily Briefing skill that integrates Gmail, Google Calendar, and Google Chat with Claude Code.

---

## Overview

### What you'll get:
- Morning briefing with calendar, emails, and chat messages
- Automatic categorization (Urgent/Important/FYI)
- Draft email responses in your communication style
- Action item extraction

### Components:
1. **Google Workspace MCP Server** - Python server that connects to Google APIs
2. **Daily Briefing Skill** - Claude Code skill that orchestrates the briefing
3. **Style Profile** (optional) - Your communication patterns for drafting responses

---

## Part 1: Install the Google Workspace MCP Server

### Step 1: Clone/Copy the Server Files

Create the directory and copy these files:

```bash
mkdir -p ~/google-workspace-mcp
cd ~/google-workspace-mcp
```

You'll need these files (I can provide them or you can get them from me):
- `server.py` - Main MCP server
- `auth.py` - Google OAuth handling
- `gmail_tools.py` - Gmail integration
- `calendar_tools.py` - Calendar integration
- `chat_tools.py` - Google Chat integration
- `setup_oauth.py` - OAuth setup script
- `requirements.txt` - Python dependencies

### Step 2: Set Up Python Environment

```bash
cd ~/google-workspace-mcp
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

**requirements.txt contents:**
```
mcp>=1.0.0
google-auth>=2.23.0
google-auth-oauthlib>=1.1.0
google-auth-httplib2>=0.1.1
google-api-python-client>=2.108.0
python-dateutil>=2.8.2
```

---

## Part 2: Set Up Google Cloud Project

### Step 1: Create Project

1. Go to https://console.cloud.google.com/
2. Click "Select a project" → "New Project"
3. Name it "Google Workspace MCP" and create

### Step 2: Enable APIs

In your project, go to **APIs & Services → Library** and enable:
- Gmail API
- Google Calendar API
- Google Chat API (for Chat integration)

### Step 3: Configure OAuth Consent Screen

1. Go to **APIs & Services → OAuth consent screen**
2. Choose **External** (or Internal if using Google Workspace)
3. Fill in:
   - App name: `Google Workspace MCP`
   - User support email: Your email
   - Developer contact: Your email
4. Click **Save and Continue**
5. **Scopes:** Click "Add or Remove Scopes" and add:
   - `https://www.googleapis.com/auth/gmail.readonly`
   - `https://www.googleapis.com/auth/gmail.compose`
   - `https://www.googleapis.com/auth/calendar.readonly`
   - `https://www.googleapis.com/auth/chat.spaces.readonly`
   - `https://www.googleapis.com/auth/chat.messages.readonly`
6. **Test users:** Add your email address
7. Complete the wizard

### Step 4: Create OAuth Credentials

1. Go to **APIs & Services → Credentials**
2. Click **Create Credentials → OAuth client ID**
3. Application type: **Desktop app**
4. Name: `Google Workspace MCP`
5. Click **Create**
6. Click **Download JSON**
7. Save the file:

```bash
mkdir -p ~/.google-workspace-mcp
mv ~/Downloads/client_secret_*.json ~/.google-workspace-mcp/credentials.json
```

---

## Part 3: Authenticate with Google

Run the OAuth setup:

```bash
cd ~/google-workspace-mcp
source venv/bin/activate
python setup_oauth.py
```

This will:
1. Open your browser
2. Ask you to sign in to Google
3. Request permissions for Gmail, Calendar, and Chat
4. Save a token to `~/.google-workspace-mcp/token.json`

---

## Part 4: Configure Claude Code

### Option A: Using Claude CLI

```bash
claude mcp add --scope user google-workspace -- \
  ~/google-workspace-mcp/venv/bin/python \
  ~/google-workspace-mcp/server.py
```

### Option B: Manual Configuration

Edit `~/.claude.json` and add to the mcpServers section:

```json
{
  "mcpServers": {
    "google-workspace": {
      "type": "stdio",
      "command": "/Users/YOUR_USERNAME/google-workspace-mcp/venv/bin/python",
      "args": ["/Users/YOUR_USERNAME/google-workspace-mcp/server.py"],
      "env": {}
    }
  }
}
```

> **Note:** Replace `YOUR_USERNAME` with your actual username.

---

## Part 5: Create the Daily Briefing Skill

### Step 1: Create Skill Directory

```bash
mkdir -p ~/.claude/skills/daily-briefing
```

### Step 2: Create the Skill File

Create `~/.claude/skills/daily-briefing/SKILL.md` with the skill content (I can share my exact file with you).

---

## Part 6: Create Your Style Profile (Optional)

For personalized email drafts, create `~/.google-workspace-mcp/style_profile.md`:

```markdown
# [Your Name] - Email Communication Style Profile

## Overview
- **Role**: [Your Title]
- **Email**: [your@email.com]
- **Tone**: [Professional but approachable / Formal / Casual]

## Greeting Patterns
- Primary: "Hi [FirstName],"
- For multiple: "Hi [Name1] and [Name2],"

## Common Phrases
- Gratitude: "Thanks" or "Thank you"
- Acknowledgment: "Got it" or "Sounds good!"
- Following up: "Following up on..."

## Things to AVOID
- [List phrases you don't use]
- Emojis (if applicable)
- Overly formal language

## Signature
[Your Name]
[Your Title]
```

---

## Part 7: Verify Setup

### 1. Restart Claude Code

```bash
claude
```

### 2. Check MCP Connection

Type `/mcp` in Claude Code. You should see `google-workspace` listed.

### 3. Test Authentication

Ask Claude: "Check my Google authentication status"

### 4. Run the Briefing

Type `/daily-briefing` to run the skill.

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "credentials.json not found" | Download OAuth credentials from Google Cloud Console |
| "Token expired" | Delete `~/.google-workspace-mcp/token.json` and run `python setup_oauth.py` again |
| "Access blocked" during OAuth | Add your email as a test user in OAuth consent screen |
| Server not appearing | Check the path in config, ensure venv has dependencies |
| Chat not working | Ensure Google Chat API is enabled and chat scopes are added |

---

## File Structure Summary

```
~/.google-workspace-mcp/
├── credentials.json      # OAuth client credentials (from Google)
├── token.json            # Your auth token (generated)
└── style_profile.md      # Your communication style (optional)

~/google-workspace-mcp/
├── venv/                 # Python virtual environment
├── server.py             # Main MCP server
├── auth.py               # OAuth handling
├── gmail_tools.py        # Gmail functions
├── calendar_tools.py     # Calendar functions
├── chat_tools.py         # Chat functions
├── setup_oauth.py        # OAuth setup script
└── requirements.txt      # Dependencies

~/.claude/skills/daily-briefing/
└── SKILL.md              # The skill definition

~/.claude.json            # Claude Code config with MCP server
```

---

## Quick Start Commands

```bash
# 1. Set up Python environment
cd ~/google-workspace-mcp && python3 -m venv venv && source venv/bin/activate && pip install -r requirements.txt

# 2. Run OAuth setup (after placing credentials.json)
python setup_oauth.py

# 3. Add MCP server to Claude
claude mcp add --scope user google-workspace -- ~/google-workspace-mcp/venv/bin/python ~/google-workspace-mcp/server.py

# 4. Test it
claude
# Then type: /daily-briefing
```
