#!/bin/bash

# Verifica che GitHub CLI sia installato
if ! command -v gh &> /dev/null; then
  echo "❌ GitHub CLI (gh) non è installato. Installalo da https://cli.github.com/"
  exit 1
fi

# Ricava il branch corrente
BRANCH=$(git branch --show-current)

# Verifica di non essere su main
if [ "$BRANCH" == "main" ]; then
  echo "⚠️ Sei su 'main'. Cambia branch prima di creare una pull request."
  exit 1
fi

# Crea la pull request con gh
gh pr create \
  --base main \
  --head "$BRANCH" \
  --title "Nuova PR da $BRANCH" \
  --body "Commit importanti da approvare da $BRANCH" \
  --web