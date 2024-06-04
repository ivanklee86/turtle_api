#!/bin/bash
set -ex

# Configure poetry
WORKSPACE_DIR=$(pwd)
poetry config cache-dir ${WORKSPACE_DIR}/.cache
poetry config virtualenvs.in-project true

# Intall dependencies
poetry install --no-root

# Install pre-config
pip install pre-commit
pre-commit install
pre-commit

# Configure git
if [ "$CODESPACES" != "true" ]; then
    echo "Running locally, configure gpg."

    git config --global gpg.program gpg2
    git config --global commit.gpgsign true
else
    echo "Running in codespaces."
fi

git config --global --add --bool push.autoSetupRemote true

# Woohoo!
echo "Hooray, it's done!"
