#!/bin/bash
# LP（index.html）の変更を GitHub Pages に反映する。
# 変更がなければ、そのまま push だけ行う。
cd "$(dirname "$0")" || exit 1
BOLD=$'\033[1m'; GREEN=$'\033[32m'; RED=$'\033[31m'; RESET=$'\033[0m'

echo "${BOLD}LP を公開します${RESET}"
echo

if [ -n "$(git status --porcelain)" ]; then
  git add -A
  printf "コミットの説明（空ならそのまま「LPを更新」）\n  > "
  read -r MSG
  [ -z "$MSG" ] && MSG="LPを更新"
  git commit -q -m "$MSG" || { echo "${RED}コミットできませんでした${RESET}"; }
fi

echo
echo "GitHub へ送信します…"
if git push origin HEAD; then
  echo
  echo "${GREEN}✔ 送信しました${RESET}"
  echo "  反映まで1〜2分かかります： https://yu-fukui.github.io/mitekara-lp/"
  echo "  ページが古いままなら、Command+Shift+R で再読み込みしてください。"
else
  echo
  echo "${RED}✖ 送信できませんでした${RESET}"
  echo "  GitHub のログインを求められた場合は、画面の指示に従ってください。"
fi

echo
echo "────────────────────────"
echo "終了しました。閉じて構いません。"
