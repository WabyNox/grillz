#!/usr/bin/env bash
# Paths (override via env o ~/.config/grillz/config)
GRILLZ_PANTRY_DEFAULT="${GRILLZ_PANTRY_DEFAULT:-$HOME/.config/grillz/recipes}"
GRILLZ_DRINKS_DEFAULT="${GRILLZ_DRINKS_DEFAULT:-$HOME/.config/grillz/drinks}"

# UI
GRILLZ_FZF_HEIGHT="${GRILLZ_FZF_HEIGHT:-70%}"
GRILLZ_FZF_OPTS="${GRILLZ_FZF_OPTS:-}"

# Mode default
GRILLZ_MODE="run"

if [ -f "$HOME/.config/grillz/config" ]; then
  # shellcheck disable=SC1090
  source "$HOME/.config/grillz/config"
fi

grillz::need() { command -v "$1" >/dev/null 2>&1 || { echo "grillz: missing command: $1" >&2; exit 1; }; }
grillz::die() { echo "grillz: $*" >&2; exit 1; }
grillz::escape_sed() { printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'; }

grillz::to_clipboard() {
  local data="$1"
  if command -v wl-copy >/dev/null 2>&1; then
    printf "%s" "$data" | wl-copy
    echo "✅ Copied to clipboard (wl-copy)." >&2
  elif command -v xclip >/dev/null 2>&1; then
    printf "%s" "$data" | xclip -selection clipboard
    echo "✅ Copied to clipboard (xclip)." >&2
  elif command -v xsel >/dev/null 2>&1; then
    printf "%s" "$data" | xsel --clipboard --input
    echo "✅ Copied to clipboard (xsel)." >&2
  elif command -v pbcopy >/dev/null 2>&1; then
    printf "%s" "$data" | pbcopy
    echo "✅ Copied to clipboard (pbcopy)." >&2
  else
    echo "⚠ No clipboard tool found (wl-copy/xclip/xsel/pbcopy). Printing below:" >&2
    echo "-----8<-----" >&2
    printf "%s\n" "$data"
    echo "-----8<-----" >&2
  fi
}
