#!/bin/bash

# Exit on error
set -e

# Check if Git is installed
if ! [ -x "$(command -v git)" ]; then
  echo 'Error: Git is not installed.' >&2
  exit 1
fi

# Initialize Git repository if not already initialized
if [ ! -d .git ]; then
  git init
  echo "Git repository initialized."
fi

# Configure Git identity (Replace with your information)
git config user.name "Your Name"
git config user.email "your.email@example.com"

# Add the GitHub repository as remote
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/RefOoSami001/WhatsAppBot.git

# Create a temporary branch
git checkout --orphan temp_branch

# Add all files to staging
git add .

# Commit changes
git commit -m "Initial commit for Render.com deployment"

# Delete the main branch
git branch -D main 2>/dev/null || true

# Rename the temporary branch to main
git branch -m main

# Force push to update the repository
echo "About to force push to the repository. This will clear all existing content."
echo "Press Ctrl+C to cancel or Enter to continue..."
read

# Force push to replace all content in the repository
git push -f origin main

echo "Repository cleared and new files uploaded successfully."
echo "Now you can deploy the application on Render.com" 