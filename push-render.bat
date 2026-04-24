@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Push FULL DPA Insight to GitHub
where git >nul 2>&1
if errorlevel 1 (
  echo Git が見つかりません。GitHub Desktop で全ファイルを Push してください。
  pause
  exit /b 1
)
if not exist "%~dp0server.js" (
  echo [エラー] このフォルダに server.js がありません。DPA-Insight のプロジェクト本体があるフォルダで実行してください。
  pause
  exit /b 1
)
if not exist "%~dp0build-icons.js" (
  echo [エラー] build-icons.js がありません。
  pause
  exit /b 1
)
echo GitHub に送る前に追跡ファイル数を表示します...
git ls-files 2>nul | find /c /v ""
echo.
echo 追跡ファイルが 10 未満なら、まだ本体が Git に載っていません。git add -A が必要です。
echo.
git add -A
git diff --cached --quiet
if errorlevel 1 (
  git commit -m "Sync full DPA Insight for Render deploy"
) else (
  echo [警告] コミットする変更がありません。git status:
  git status -s
  echo.
  echo 未追跡ファイルがある場合: git add -A してから再度この bat を実行してください。
)
git push origin main
if errorlevel 1 (
  echo Push に失敗しました。
  pause
  exit /b 1
)
echo.
echo OK。ブラウザで次を開き、server.js や build-icons.js が一覧に出るか確認してください:
echo https://github.com/nekosyougun2222-droid/DPA-Insight2/tree/main
echo.
for /f "delims=" %%H in ('git rev-parse --short HEAD 2^>nul') do echo いまのローカル先頭コミット: %%H
echo Render の dpa-insight → Settings → Root Directory は空にしてください。
pause
