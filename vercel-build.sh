#!/bin/bash
set -e

# Setup SSH
mkdir -p ~/.ssh
echo "$CONTENT_SSH_KEY" > ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_ed25519
ssh-keyscan git.app.uib.no >> ~/.ssh/known_hosts

# Start ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Fetch submodules
git submodule update --init --recursive

# Continue build
npm install
next build