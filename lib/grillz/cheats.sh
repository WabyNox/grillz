#!/usr/bin/env bash
grillz::list_recipe_files() {
  local files=()
  if [ -d "$GRILLZ_PANTRY_DEFAULT" ]; then
    mapfile -t files < <(find "$GRILLZ_PANTRY_DEFAULT" -type f -name '*.md' 2>/dev/null | sort || true)
  fi
  (( ${#files[@]} == 0 )) && grillz::die "no recipes found."
  printf "%s\n" "${files[@]}"
}

grillz::list_cheats() {
  grillz::list_recipe_files | while read -r file; do
    awk -v F="$file" '
      BEGIN { desc=""; cmd=""; in_code=0 }
      {
        if ($0 ~ /^```/) { in_code = !in_code; next }
        if (in_code) next

        if ($0 ~ /^#[[:space:]]+/) {
          desc = $0
          sub(/^#[[:space:]]+/, "", desc)

          while (getline line) {
            if (line ~ /^```/) {
              while (getline inner && inner !~ /^```/) { }
              next
            }
            if (line ~ /^[[:space:]]*$/) next
            if (line ~ /^#[[:space:]]+/) continue
            cmd = line
            break
          }

          if (desc != "" && cmd != "") print desc "\t" cmd "\t" F
        }
      }
    ' "$file"
  done
}

grillz::select_cheat() {
  local selection
  local BIND_OPTS; BIND_OPTS="$(grillz::build_fzf_binds)"
  local user_opts=()
  if [[ -n "${GRILLZ_FZF_OPTS:-}" ]]; then
    # shellcheck disable=SC2206
    user_opts=( ${GRILLZ_FZF_OPTS} )
  fi

  selection="$(
    grillz::list_cheats \
    | awk -F'\t' '{printf "%s\t%s\t%s\n",$1,$2,$3}' \
    | fzf --ansi --extended --delimiter=$'\t' --with-nth=1 \
          --prompt='grillz 🔥 > ' \
          --height="${GRILLZ_FZF_HEIGHT}" \
          --layout=reverse --border --margin=1 --padding=1 \
          --tiebreak=begin,index \
          --preview-window=up,60%,wrap,border \
          --preview='printf "🍖  Recipe:\n%s\n\n🔧  Preparation:\n%s\n" {1} {2}' \
          ${BIND_OPTS:+$BIND_OPTS} "${user_opts[@]}"
  )" || return 1

  printf '%s\n' "$(awk -F'\t' '{print $1}' <<<"$selection")"
  printf '%s\n' "$(awk -F'\t' '{print $2}' <<<"$selection")"
}

grillz::fill_variables() {
  local template="$1"; local quiet="${2:-0}"
  mapfile -t vars < <(grep -oE '<[^>]+>' <<<"$template" | sed 's/[<>]//g' | awk '!seen[$0]++')
  local result="$template"
  (( ${#vars[@]} == 0 )) && { printf "%s" "$result"; return 0; }

  (( quiet == 0 )) && printf "📜 Base recipe:\n%s\n\n" "$template" >&2
  for var in "${vars[@]}"; do
    local input
    if (( quiet == 0 )); then
      read -rp "🔪 Ingredient «$var»: " input
    else
      read -rp "$var: " input
    fi
    local from to
    from="$(grillz::escape_sed "<$var>")"
    to="$(grillz::escape_sed "$input")"
    result="$(printf "%s" "$result" | sed "s/$from/$to/g")"
    (( quiet == 0 )) && printf "🔥 Searing:\n%s\n\n" "$result" >&2
  done
  printf "%s" "$result"
}

grillz::list_drink_files() {
  local files=()
  if [ -d "$GRILLZ_DRINKS_DEFAULT" ]; then
    mapfile -t files < <(find "$GRILLZ_DRINKS_DEFAULT" -type f -name '*.md' 2>/dev/null | sort || true)
  fi
  (( ${#files[@]} == 0 )) && grillz::die "no drinks found (create $GRILLZ_DRINKS_DEFAULT)"
  printf "%s\n" "${files[@]}"
}

grillz::list_drinks() {
  grillz::list_drink_files | while read -r file; do
    awk -v F="$file" '
      BEGIN { desc=""; cmd=""; in_code=0 }
      {
        if ($0 ~ /^```/) { in_code = !in_code; next }
        if (in_code) next

        if ($0 ~ /^#[[:space:]]+/) {
          desc = $0
          sub(/^#[[:space:]]+/, "", desc)

          while (getline line) {
            if (line ~ /^```/) {
              while (getline inner && inner !~ /^```/) { }
              next
            }
            if (line ~ /^[[:space:]]*$/) next
            if (line ~ /^#[[:space:]]+/) continue
            cmd = line
            break
          }

          if (desc != "" && cmd != "") print desc "\t" cmd "\t" F
        }
      }
    ' "$file"
  done
}

grillz::select_drink() {
  local selection
  local BIND_OPTS; BIND_OPTS="$(grillz::build_fzf_binds)"
  selection="$(
    grillz::list_drinks \
    | awk -F'\t' '{printf "%s\t%s\t%s\n",$1,$2,$3}' \
    | fzf --ansi --extended --delimiter=$'\t' --with-nth=1 \
          --prompt='drinks 🍸 > ' \
          --height="${GRILLZ_FZF_HEIGHT}" \
          --layout=reverse --border --margin=1 --padding=1 \
          --tiebreak=begin,index \
          --preview-window=up,60%,wrap,border \
          --preview='printf "🍸  Drink:\n%s\n\n🧾  Payload:\n%s\n" {1} {2}' \
          $BIND_OPTS ${GRILLZ_FZF_OPTS}
  )" || return 1

  printf '%s\n' "$(awk -F'\t' '{print $1}' <<<"$selection")"
  printf '%s\n' "$(awk -F'\t' '{print $2}' <<<"$selection")"
}
