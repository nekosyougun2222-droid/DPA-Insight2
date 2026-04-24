@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Push ALL files to GitHub (required for Render)
where git >nul 2>&1
if errorlevel 1 (
  echo Git が見つかりません。GitHub Desktop で「変更のあるファイルをすべて」Commit して Push してください。
  pause
  exit /b 1
)
echo このフォルダの全ファイルを GitHub に送ります（Render に必要な server.js など含む）...
git add -A
git commit -m "Sync full DPA Insight app for Render" 2>nul
git push origin main
if errorlevel 1 (
  echo Push に失敗しました。GitHub Desktop から Push するか、認証を確認してください。
  pause
  exit /b 1
)
echo.
echo OK。GitHub の main を確認し、Render で再デプロイしてください。
echo Render のサービス設定で Root Directory が src なら空にしてください。
pause
