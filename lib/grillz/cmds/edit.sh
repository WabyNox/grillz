#!/usr/bin/env bash
grillz::cmd_edit() {
  mkdir -p "$GRILLZ_PANTRY_DEFAULT"

  # Preferisci VISUAL su EDITOR, poi nano
  local editor="${VISUAL:-${EDITOR:-nano}}"
  local target="${1:-}"

  if [ -z "$target" ]; then
    grillz::need fzf
    # ordinamento stabile e preview del path relativo
    mapfile -t files < <(LC_ALL=C find "$GRILLZ_PANTRY_DEFAULT" -type f -name '*.md' 2>/dev/null | LC_ALL=C sort || true)
    (( ${#files[@]} == 0 )) && grillz::die "no .md files in $GRILLZ_PANTRY_DEFAULT"

    # Mostra path relativi al pantry nel picker, ma ritorna assoluto
    local rel
    rel="$(printf "%s\n" "${files[@]}" \
            | sed -e "s|^$GRILLZ_PANTRY_DEFAULT/||" \
            | fzf --ansi \
                  --prompt='grillz edit > ' \
                  --height="${GRILLZ_FZF_HEIGHT:-70%}" \
                  --layout=reverse --border --margin=1 --padding=1 \
                  --preview-window=right,60%,wrap,border \
                  --preview 'printf "📄 %s\n\n" {} && sed -n "1,120p" "'"$GRILLZ_PANTRY_DEFAULT"'/{}' )" || exit 130
    [ -z "$rel" ] && exit 130
    target="$GRILLZ_PANTRY_DEFAULT/$rel"

  else
    # Se è un path esistente, ok
    if [ -f "$target" ]; then
      :
    # Se è relativo, prova nel pantry
    elif [ -f "$GRILLZ_PANTRY_DEFAULT/$target" ]; then
      target="$GRILLZ_PANTRY_DEFAULT/$target"
    else
      # Cerca per basename (primo match)
      local found
      found="$(LC_ALL=C find "$GRILLZ_PANTRY_DEFAULT" -type f -name "$(basename "$target")" 2>/dev/null | head -n1 || true)"
      if [ -n "$found" ]; then
        target="$found"
      else
        # Offri creazione file nel pantry
        printf "⚠ File not found: %s\n" "$target" >&2
        read -r -p "Create it under $GRILLZ_PANTRY_DEFAULT? [y/N] " ans
        if [[ "$ans" =~ ^[Yy]$ ]]; then
          target="$GRILLZ_PANTRY_DEFAULT/$target"
          mkdir -p "$(dirname "$target")"
          printf "# [Phase] Description --tool\n<command>\n" > "$target"
          echo "✓ Created: $target" >&2
        else
          grillz::die "file not found in $GRILLZ_PANTRY_DEFAULT: $target"
        fi
      fi
    fi
  fi

  "$editor" "$target"
}
