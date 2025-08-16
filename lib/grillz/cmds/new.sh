#!/usr/bin/env bash
grillz::cmd_new() {
  mkdir -p "$GRILLZ_PANTRY_DEFAULT"
  [ $# -ge 2 ] || grillz::die 'usage: grillz new "Description" "Command with <var>"'
  local file="$GRILLZ_PANTRY_DEFAULT/custom.md"
  printf "# %s\n%s\n\n" "$1" "$2" >> "$file"
  printf "✅ New recipe added to %s\n" "$file" >&2
}
}
