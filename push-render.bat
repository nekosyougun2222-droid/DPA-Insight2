@echo off
chcp 65001 >nul
cd /d "%~dp0"
title push render.yaml to GitHub
where git >nul 2>&1
if errorlevel 1 (
  echo Git が見つかりません。GitHub Desktop で render.yaml を Commit して Push してください。
  pause
  exit /b 1
)
git add render.yaml
git commit -m "Add render.yaml for Render Blueprint (free tier)" 2>nul
git push origin main
if errorlevel 1 (
  echo Push に失敗しました。GitHub Desktop から Push するか、認証を確認してください。
  pause
  exit /b 1
)
echo OK: GitHub の main に render.yaml を送りました。Render で Blueprint を再同期してください。
pause
