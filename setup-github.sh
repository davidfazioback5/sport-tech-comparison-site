#!/bin/bash
# ClubTech Compare — GitHub setup script
# Run this once from Terminal to create the repo and push all files.
#
# Prerequisites:
#   1. A GitHub account
#   2. GitHub CLI installed: https://cli.github.com  (or brew install gh)
#      — OR — a Personal Access Token ready for the manual steps below.
#
# ─────────────────────────────────────────────────────────────────────────────

set -e
cd "$(dirname "$0")"

REPO_NAME="clubtech-compare"
REPO_DESC="ClubTech Compare — Independent sports club software reviews and comparison site"

echo "🏟️  ClubTech Compare — GitHub Setup"
echo "======================================"

# 1. Init git
if [ ! -d ".git" ]; then
  git init
  git branch -m main
  echo "✓ Git initialised"
else
  echo "✓ Git already initialised"
fi

# 2. Configure identity (edit if needed)
git config user.name  "David Fazio"
git config user.email "david.fazio@outlook.com"

# 3. Stage and commit everything
git add -A
git commit -m "Initial commit — ClubTech Compare website

- Homepage with comparison table, review cards, lead capture
- 3 category pages: Club Management, Performance Tracking, Monetisation
- 6 platform review pages: 360Player, Back5, Spond, TeamSnap, Pitchero, Playertek
- Interactive buyer's quiz with weighted platform scoring
- Monetisation consulting services page
- Shared CSS (G2/Capterra style) and JS (UTM passthrough, mobile nav)" 2>/dev/null || echo "✓ Nothing new to commit (already committed)"

echo ""
echo "────────────────────────────────────"
echo "  Choose how to push to GitHub:"
echo "────────────────────────────────────"
echo ""

# Try GitHub CLI first
if command -v gh &> /dev/null; then
  echo "GitHub CLI detected — creating repo and pushing..."
  gh auth status 2>/dev/null || gh auth login
  gh repo create "$REPO_NAME" \
    --description "$REPO_DESC" \
    --private \
    --source=. \
    --remote=origin \
    --push
  echo ""
  echo "✅  Done! Your repo is live:"
  gh repo view --web
else
  echo "GitHub CLI not found."
  echo ""
  echo "OPTION A — Install GitHub CLI (recommended):"
  echo "  brew install gh"
  echo "  Then re-run this script."
  echo ""
  echo "OPTION B — Manual push:"
  echo "  1. Go to https://github.com/new"
  echo "  2. Create a repo named: $REPO_NAME"
  echo "  3. Copy the repo URL (e.g. https://github.com/YOUR_USERNAME/$REPO_NAME.git)"
  echo "  4. Run:"
  echo "     git remote add origin https://github.com/YOUR_USERNAME/$REPO_NAME.git"
  echo "     git push -u origin main"
  echo ""
  echo "✓ Local commit is ready — just add the remote and push."
fi
