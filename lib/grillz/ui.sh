#!/usr/bin/env bash
grillz::banner() {
  cat >&2 <<'EOF'

                ▄████  ██▀███  ██▓ ██▓     ██▓      ▒███████▓
               ██▒ ▀█▒▓██ ▒ ██▒▓██▒▓██▒     ▓██▒    ▓█   ▓██▒
              ▒██░▄▄▄░▓██ ░▄█ ▒▒██▒▒██░     ▒██░       ▒██░
              ░▓█  ██▓▒██▀▀█▄  ░██░▒██░     ▒██░     ▄███
              ░▒▓███▀▒░██▓ ▒██▒░██░░███████ ░███████░████████
               ░▒   ▒ ░ ▒▓ ░▒▓░░▓  ░        ░        ░░ ▒░ ░
                ░   ░   ░▒ ░ ▒░ ▒ ░                    ░ ░
              ░ ░   ░   ░░   ░  ▒ ░                      ░
                ░    ░      ░                        ░

                            🔥  G R I L L Z  🔥
                      hack the kitchen • burn the ops

EOF
}

grillz::fzf_has_action() { fzf --help 2>&1 | grep -qE "(^|[^-])$1(,| |$)"; }
grillz::build_fzf_binds() {
  local binds=()
  grillz::fzf_has_action toggle-sort  && binds+=("alt-s:toggle-sort")
  grillz::fzf_has_action toggle-case  && binds+=("alt-c:toggle-case")
  grillz::fzf_has_action toggle-exact && binds+=("alt-e:toggle-exact")
  local out=""; for b in "${binds[@]}"; do out+=" --bind=$b"; done
  printf '%s' "$out"
}


grillz::quick_menu() {
  local height="${GRILLZ_FZF_HEIGHT:-60%}"

  # Header (multilinea)
  local header
  read -r -d '' header <<'EOF'
╔════════════════════════════════════════════════════════════╗
║ BEERS IN THE FRIDGE: 4                                     ║
╠════════════════════════════════════════════════════════════╣
║ CAFFEINE LEVEL: CRITIC                                     ║
╚════════════════════════════════════════════════════════════╝
EOF

  # Costruiamo un set di opzioni fzf "sanitizzate" per il QUICK MENU
  # (evita che user GRILLZ_FZF_OPTS reimposti prompt/layout/header)
  local safe_opts=()
  safe_opts+=(--ansi)
  safe_opts+=(--header="$header" --header-first)
  safe_opts+=(--with-nth=2 --delimiter=$'\t')
  safe_opts+=(--prompt='▶ ')
  safe_opts+=(--pointer='➤' --marker='✓')
  safe_opts+=(--layout=reverse)       # prompt in alto sotto header
  safe_opts+=(--no-sort --tiebreak=index)
  safe_opts+=(--info=hidden)
  safe_opts+=(--border=rounded --margin=1 --padding=1)
  safe_opts+=(--height="$height")

  # Se il terminale è stretto, usa border "single" per evitare wrapping antiestetico
  if [ "${COLUMNS:-100}" -lt 80 ]; then
    safe_opts=( "${safe_opts[@]/--border=rounded/--border}" )
  fi

  # Filtra alcune opzioni pericolose dall'override utente
  # (no prompt/layout/header che sfalsano il menu)
  local user_opts=(${GRILLZ_FZF_OPTS:-})
  local filtered=()
  for opt in "${user_opts[@]}"; do
    case "$opt" in
      --prompt=*|--layout=*|--header=*|--header-first|--no-header|--with-nth=*|--delimiter=* )
        # scartiamo
        ;;
      *) filtered+=("$opt") ;;
    esac
  done

  local rows=(
    $'Recipes\t\033[36m▶ Recipes\033[0m      \033[2m— Cook your command and grill your enemies\033[0m'
    $'Drinks\t\033[35m▶ Drinks\033[0m       \033[2m— Make a nice drink\033[0m'
    $'Options\t\033[33m▶ Options\033[0m      \033[2m— Adjust the flame\033[0m'
    $'Help\t\033[32m▶ Help\033[0m         \033[2m— Reading the boring manual\033[0m'
  )

  local sel
  sel="$(
    printf '%b\n' "${rows[@]}" \
    | awk -F'\t' 'NF>=2' \
    | fzf "${safe_opts[@]}" "${filtered[@]}"
  )" || return 1

  awk -F'\t' 'NR==1{print $1}' <<<"$sel"
}



# -----------------------LEGACY MENU------------------
#grillz::quick_menu() {
#  local choice
#  choice=$(printf "Recipes\nDrinks\nOptions\nHelp" \
#    | fzf --prompt='Main menu > ' \
#          --height=20% \
#          --layout=reverse \
#          --border \
#          --margin=1 \
#          --padding=1 \
#          --tiebreak=index)
#  printf '%s\n' "$choice"
#}
