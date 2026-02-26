# Troubleshooting

Common issues and how to fix them.

## "Browser not found" or "rfbrowser init" errors

**Problem:** Tests fail with browser-related errors.

**Fix:**
```bash
uv run rfbrowser init chromium
```

This downloads Chromium browser binaries (~250MB). It's a one-time download.

**If it still fails:**
```bash
# Install system dependencies (Linux)
npx playwright install-deps chromium

# Then retry
uv run rfbrowser init chromium
```

## "Timeout waiting for selector"

**Problem:** Test fails waiting for an element on the page.

**Possible causes:**
1. **Wrong selector** — Double-check the CSS selector against the page
2. **Page not loaded** — Add a wait or check navigation completed
3. **SauceDemo is down** — Try opening https://www.saucedemo.com in your browser

**Debug tip:** Run with visible browser:
```bash
uv run robot --variable HEADLESS:false tests/your_test.robot
```

## DevContainer build fails

**Problem:** Codespace or DevContainer won't build.

**Possible causes:**
1. **Docker not running** (local setup) — Start Docker Desktop
2. **Insufficient disk space** — Free up space or increase Docker disk allocation
3. **Network issues** — Check internet connection

**Fix for Codespace:** Try deleting the Codespace and creating a new one.

## "Permission denied" on rfbrowser

**Problem:** `rfbrowser init` fails with permission errors.

**Fix:**
```bash
# In DevContainer, try:
uv run rfbrowser init chromium

# If that fails, use sudo for system deps:
sudo npx playwright install-deps chromium
uv run rfbrowser init chromium
```

## Tests pass locally but fail in CI

**Possible causes:**
1. **Headless mode** — CI runs headless. Make sure your tests work with `headless=${True}`
2. **Timing** — CI machines may be slower. Avoid `Sleep`; use Browser Library's auto-wait
3. **Dependencies** — Make sure `uv.lock` is committed and up to date

**Fix:** Always test with headless mode before pushing:
```bash
uv run robot --variable HEADLESS:true tests/
```

## "uv: command not found"

**Fix:**
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.bashrc  # or restart your terminal
```

## "No module named 'Browser'"

**Fix:**
```bash
uv sync  # Install dependencies first
```

## Understanding Test Results

After running tests, check the `results/` directory:

- **`report.html`** — High-level summary: pass/fail counts, statistics
- **`log.html`** — Detailed execution log: every keyword, every argument, every screenshot
- **`output.xml`** — Machine-readable results (used by CI)

Open `log.html` in your browser for the most useful debugging information. You can:
- Expand test cases to see each keyword's execution
- Click on failed keywords to see error messages
- View screenshots taken during the test

## Environment Check Script

Run this to diagnose all issues at once:

```bash
python scripts/check_environment.py
```

It checks 11 prerequisites and shows exactly what's wrong and how to fix it.
