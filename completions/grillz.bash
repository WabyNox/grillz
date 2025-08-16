# Source this from ~/.bashrc (see README)

_grillz_complete() {
  local cur prev pantry
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  pantry="${GRILLZ_PANTRY_DEFAULT:-$HOME/.config/grillz/recipes}"

  local subs="recipes drinks new list edit install uninstall link unlink paths doctor"
  local flags="-h --help -V --version -r --run -p --print -q --quiet -R --recipes -D --drinks"

  case "$prev" in
    edit)
      if command -v find >/dev/null 2>&1; then
        local files=()
        if find "$pantry" -type f -name '*.md' -printf '%P\n' >/dev/null 2>&1; then
          mapfile -t files < <(find "$pantry" -type f -name '*.md' -printf '%P\n' 2>/dev/null)
        else
          mapfile -t files < <(find "$pantry" -type f -name '*.md' 2>/dev/null | sed "s|^$pantry/||")
        fi
        COMPREPLY=( $(compgen -W "${files[*]}" -- "$cur") )
        return 0
      fi
      ;;
  esac

  COMPREPLY=( $(compgen -W "$subs $flags" -- "$cur") )
  return 0
}

complete -F _grillz_complete grillz
