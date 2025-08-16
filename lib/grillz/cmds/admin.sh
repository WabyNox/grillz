#!/usr/bin/env bash

# ===== Install config =====
: "${PREFIX:=$HOME/.local}"
GRILLZ_BINDIR="$PREFIX/bin"
GRILLZ_LIBTOP="$PREFIX/lib"
GRILLZ_LIBDIR="$GRILLZ_LIBTOP/grillz"

grillz::resolve_dir() {
  local src="$1"
  while [ -L "$src" ]; do
    local t; t="$(readlink "$src")"
    if [[ "$t" != /* ]]; then
      src="$(cd -P "$(dirname "$src")" && pwd)/$t"
    else
      src="$t"
    fi
  done
  cd -P "$(dirname "$src")" >/dev/null 2>&1 && pwd
}

# Where is the running bin/grillz?
grillz::self_dir() { grillz::resolve_dir "${BASH_SOURCE[0]}"; }

grillz::repo_root() {
  local sd root=""
  sd="$(grillz::self_dir 2>/dev/null || true)"
  if [ -n "${sd:-}" ] && [ -d "$sd/../lib/grillz" ]; then
    root="$(cd -P "$sd/.." && pwd)"
  elif [ -f "$GRILLZ_LIBDIR/version.sh" ]; then
    root="$(cd -P "$GRILLZ_LIBDIR/.." && pwd)"
  else
    root="$(pwd)"
  fi
  printf '%s\n' "$root"
}

# ----- Admin: show paths
grillz::cmd_paths() {
  local root; root="$(grillz::repo_root)"
  printf "PREFIX         : %s\n" "$PREFIX"
  printf "BIN target     : %s/grillz\n" "$GRILLZ_BINDIR"
  printf "LIB target     : %s\n" "$GRILLZ_LIBDIR"
  printf "Completions    : %s/grillz-completions\n" "$GRILLZ_LIBTOP"
  printf "Repo root      : %s\n" "$root"
}

# ----- Admin: install (copy bin + lib)
grillz::cmd_install() {
  local root; root="$(grillz::repo_root)"
  local src_bin="$root/bin/grillz"
  local src_lib="$root/lib/grillz"
  [ -f "$src_bin" ] || grillz::die "cannot find $src_bin"
  [ -d "$src_lib" ] || grillz::die "cannot find $src_lib"

  mkdir -p "$GRILLZ_BINDIR" "$GRILLZ_LIBDIR"
  install -m 0755 "$src_bin" "$GRILLZ_BINDIR/grillz"
  cp -r "$src_lib/." "$GRILLZ_LIBDIR/"
  find "$GRILLZ_LIBDIR" -type f -exec chmod 0644 {} \; 2>/dev/null || true
  chmod 0755 "$GRILLZ_LIBDIR"/*.sh "$GRILLZ_LIBDIR"/cmds/*.sh 2>/dev/null || true

  echo "✓ Installed:"
  echo "  - $GRILLZ_BINDIR/grillz"
  echo "  - $GRILLZ_LIBDIR"

  # Pantry bootstrap
  mkdir -p "$HOME/.config/grillz/recipes" "$HOME/.config/grillz/drinks"

  # Completions
  local src_compl="$root/completions"
  if [ -d "$src_compl" ]; then
    mkdir -p "$GRILLZ_LIBTOP/grillz-completions"
    cp -r "$src_compl/." "$GRILLZ_LIBTOP/grillz-completions/"
    echo "  - completions → $GRILLZ_LIBTOP/grillz-completions"
    cat <<'EON' >&2
Hints:
  Bash:
    echo 'source ~/.local/lib/grillz-completions/grillz.bash' >> ~/.bashrc
  Zsh:
    echo 'fpath=("$HOME/.local/lib/grillz-completions" $fpath)' >> ~/.zshrc
    echo 'autoload -Uz compinit && compinit' >> ~/.zshrc
EON
  fi

  local src_examples="$root/examples/recipes"
  [ -d "$src_examples" ] && echo "  - examples present: $src_examples (copy manually)"
}

# ----- Admin: uninstall
grillz::cmd_uninstall() {
  echo "→ Removing $GRILLZ_BINDIR/grillz (if present)"
  rm -f "$GRILLZ_BINDIR/grillz" || true

  echo "→ Removing $GRILLZ_LIBDIR"
  rm -rf "$GRILLZ_LIBDIR" || true

  if [ -d "$GRILLZ_LIBTOP/grillz-completions" ]; then
    echo "→ Removing completions at $GRILLZ_LIBTOP/grillz-completions"
    rm -rf "$GRILLZ_LIBTOP/grillz-completions" || true
  fi

  echo "✓ Uninstalled."
}

# ----- Dev: link (symlink repo → PREFIX)
grillz::cmd_link() {
  local root; root="$(grillz::repo_root)"
  local src_bin="$root/bin/grillz"
  local src_lib="$root/lib/grillz"
  [ -f "$src_bin" ] || grillz::die "cannot find $src_bin"
  [ -d "$src_lib" ] || grillz::die "cannot find $src_lib"

  mkdir -p "$GRILLZ_BINDIR" "$GRILLZ_LIBTOP"
  ln -snf "$src_bin" "$GRILLZ_BINDIR/grillz"
  ln -snf "$src_lib" "$GRILLZ_LIBDIR"
  echo "✓ Linked:"
  echo "  - $GRILLZ_BINDIR/grillz -> $src_bin"
  echo "  - $GRILLZ_LIBDIR -> $src_lib"
}

# ----- Dev: unlink (remove symlinks only)
grillz::cmd_unlink() {
  [ -L "$GRILLZ_BINDIR/grillz" ] && rm -f "$GRILLZ_BINDIR/grillz" || true
  [ -L "$GRILLZ_LIBDIR" ] && rm -f "$GRILLZ_LIBDIR" || true
  echo "✓ Unlinked symlinks."
}

# ----- Health check
grillz::cmd_doctor() {
  echo "=== Grillz Doctor ==="
  printf "fzf present        : "; if command -v fzf >/dev/null 2>&1; then echo "yes"; else echo "NO (install fzf)"; fi
  printf "bin installed      : "; if [ -x "$GRILLZ_BINDIR/grillz" ]; then echo "yes ($GRILLZ_BINDIR/grillz)"; else echo "no"; fi
  printf "lib present        : "; if [ -f "$GRILLZ_LIBDIR/version.sh" ]; then echo "yes ($GRILLZ_LIBDIR)"; else echo "no"; fi
  printf "bin in PATH        : "
  case ":$PATH:" in *":$GRILLZ_BINDIR:"*) echo "yes" ;; *) echo "no (export PATH=\$PATH:$GRILLZ_BINDIR)" ;; esac

  printf "pantry directories : "
  if [ -d "$HOME/.config/grillz/recipes" ] && [ -d "$HOME/.config/grillz/drinks" ]; then
    echo "ok"
  else
    echo "missing → creating..."
    mkdir -p "$HOME/.config/grillz/recipes"/{shared,tools} "$HOME/.config/grillz/drinks"
    echo "created"
  fi

  if [ -d "$GRILLZ_LIBTOP/grillz-completions" ]; then
    echo "completions        : found at $GRILLZ_LIBTOP/grillz-completions"
  else
    echo "completions        : not found (optional)"
  fi
  echo "====================="
}
