@echo off
echo Preparing to clear and upload files to GitHub repository

REM Check if Git is installed
where git >nul 2>nul
if %ERRORLEVEL% neq 0 (
  echo Error: Git is not installed.
  exit /b 1
)

REM Initialize Git repository if not already initialized
if not exist .git (
  git init
  echo Git repository initialized.
)

REM Configure Git identity (Replace with your information)
echo Please enter your Git username:
set /p GIT_USERNAME=
echo Please enter your Git email:
set /p GIT_EMAIL=

git config user.name "%GIT_USERNAME%"
git config user.email "%GIT_EMAIL%"

REM Add the GitHub repository as remote
git remote remove origin 2>nul
git remote add origin https://github.com/RefOoSami001/WhatsAppBot.git

REM Create a temporary branch
git checkout --orphan temp_branch

REM Add all files to staging
git add .

REM Commit changes
git commit -m "Initial commit for Render.com deployment"

REM Delete the main branch if it exists
git branch -D main 2>nul

REM Rename the temporary branch to main
git branch -m main

REM Force push to update the repository
echo About to force push to the repository. This will clear all existing content.
echo Press Ctrl+C to cancel or any key to continue...
pause

REM Force push to replace all content in the repository
git push -f origin main

echo Repository cleared and new files uploaded successfully.
echo Now you can deploy the application on Render.com
pause 