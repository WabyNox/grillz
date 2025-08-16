#!/usr/bin/env bash

GRILLZ_DIRECT=""

grillz::parse_args() {
  GRILLZ_DIRECT=""
  while (( $# )); do
    case "$1" in
      -h|--help)    grillz::print_help; exit 0 ;;
      -V|--version) printf "%s\n" "$GRILLZ_VERSION"; exit 0 ;;

      -r|--run)     GRILLZ_MODE="run";   shift ;;
      -p|--print)   GRILLZ_MODE="print"; shift ;;
      -q|--quiet)   GRILLZ_MODE="quiet"; shift ;;

      -d|-D|--drinks)  GRILLZ_DIRECT="drinks";  shift ;;
      -R|--recipes)    GRILLZ_DIRECT="recipes"; shift ;;

      --) shift; break ;;
      -*) grillz::die "unknown option: $1" ;;
      *)  break ;;
    esac
  done
  REM_ARGS=("$@")
}

grillz::main() {
  grillz::need fzf
  grillz::parse_args "$@"
  set -- "${REM_ARGS[@]:-}"

  if [[ -z "${1:-}" && -n "${GRILLZ_DIRECT:-}" ]]; then
    set -- "$GRILLZ_DIRECT"
  fi

  case "${1:-}" in
    new)
      shift
      [ $# -lt 2 ] && grillz::die 'usage: grillz new "Description" "Command with <var>"'
      grillz::cmd_new "$@"; exit 0 ;;

    list)
      shift || true
      grillz::cmd_list; exit 0 ;;

    edit)
      shift
      grillz::cmd_edit "${1:-}"; exit 0 ;;

    install)
      shift || true
      grillz::cmd_install; exit 0 ;;

    uninstall|unistall)
      shift || true
      grillz::cmd_uninstall; exit 0 ;;

    link)
      shift || true
      grillz::cmd_link; exit 0 ;;

    unlink)
      shift || true
      grillz::cmd_unlink; exit 0 ;;

    paths)
      shift || true
      grillz::cmd_paths; exit 0 ;;

    doctor)
      shift || true
      grillz::cmd_doctor; exit 0 ;;

    recipes)
      shift || true
      grillz::_run_recipes_flow; exit $? ;;

    drinks)
      shift || true; 
      grillz::_run_drinks_flow;  exit $? ;;

  esac

  [[ "$GRILLZ_MODE" != "quiet" ]] && grillz::banner

  local menu_choice
  menu_choice="$(grillz::quick_menu || true)"
  case "$menu_choice" in
    Recipes)
      grillz::_run_recipes_flow ;;

    Drinks)
      grillz::_run_drinks_flow ;;

    Options)
      echo "⚙ Options not implemented yet." ;;

    Help)
      grillz::print_help ;;

    ""|Quit)
      exit 0
      ;;
  esac
}

grillz::_run_recipes_flow() {
  [[ "$GRILLZ_MODE" != "quiet" ]] && grillz::banner
  local out desc cmd final QUIET=0
  mapfile -t out < <(grillz::select_cheat) || return 130
  desc="${out[0]-}"; cmd="${out[1]-}"
  [[ -n "$cmd" ]] || return 1
  [[ "$GRILLZ_MODE" == "quiet" ]] && QUIET=1
  final="$(grillz::fill_variables "$cmd" "$QUIET")"
  case "$GRILLZ_MODE" in
    run|quiet) eval "$final" ;;
    print)     printf "%s\n" "$final" ;;
  esac
}

grillz::_run_drinks_flow() {
  [[ "$GRILLZ_MODE" != "quiet" ]] && grillz::banner
  local outd descd payloadd finald QUIETD=0
  mapfile -t outd < <(grillz::select_drink) || return 130
  descd="${outd[0]-}"; payloadd="${outd[1]-}"
  [[ -n "$payloadd" ]] || return 1
  [[ "$GRILLZ_MODE" == "quiet" ]] && QUIETD=1
  finald="$(grillz::fill_variables "$payloadd" "$QUIETD")"
  grillz::to_clipboard "$finald"
  printf "%s\n" "$finald"
}
