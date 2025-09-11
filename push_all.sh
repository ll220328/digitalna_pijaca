#!/bin/bash

# Učitaj korisničku konfiguraciju
if [ -f "./config.sh" ]; then
    source ./config.sh
else
    echo "Greška: config.sh nije pronađen!"
    echo "Kopiraj primer i unesi svoje podatke."
    exit 1
fi

BRANCH="master"

# Remote repozitorijumi (NE MENJATI)
GH_REMOTE="https://github.com/${GH_USER}/digitalna_pijaca.git"
GERRIT_REMOTE="ssh://${GERRIT_USER}@crete.etf.bg.ac.rs:29418/project_GreenNode"

# Push na GitHub
echo "Pushing na GitHub kao $GH_USER na branch $BRANCH ..."
git push "$GH_REMOTE" "$BRANCH"

# Push na Gerrit
echo "Pushing na Gerrit kao $GERRIT_USER na branch $BRANCH ..."
git push "$GERRIT_REMOTE" "$BRANCH"

echo "Završeno!"

