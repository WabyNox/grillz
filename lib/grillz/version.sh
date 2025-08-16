#!/usr/bin/env bash
GRILLZ_VERSION="1.1.0"

grillz::print_help() {
  cat >&2 <<'EOF'
GRILLZ – hack the kitchen • burn the ops

USAGE
  grillz [options]                 # banner → quick menu
  grillz [options] recipes         # open Recipes mode directly
  grillz [options] drinks          # open Drinks mode directly

SUBCOMMANDS
  recipes               Run recipe flow (fzf → fill vars → run/print)
  drinks                Run drinks flow (fzf → fill vars → clipboard)
  new "Desc" "Cmd"      Append a new entry to a recipe file
  list                  List recipe files (paths)
  edit [file]           Edit a recipe (.md) via $EDITOR or fzf
  install               Copy bin+lib to PREFIX (default: ~/.local)
  uninstall             Remove installed copies from PREFIX
  link                  Dev: symlink repo → PREFIX
  unlink                Dev: remove symlinks
  paths                 Show install/dev paths
  doctor                Environment checks

OPTIONS
  -r, --run             Execute final command (default).
  -p, --print           Print final command only (do not execute).
  -q, --quiet           Minimal prompts (no banner).
  -R, --recipes         Shortcut: same as 'grillz recipes'.
  -D, --drinks          Shortcut: same as 'grillz drinks'.
  -h, --help            Show this help and exit.
  -V, --version         Show version and exit.

PANTRY
  Recipes (runnable):   ~/.config/grillz/recipes  (recursive)
  Drinks  (payloads):   ~/.config/grillz/drinks   (recursive)

RECIPE FORMAT
  # [Phase] Description --tool
  command with <var1> ... <varN>

EXAMPLES
  grillz -R                  # jump to Recipes
  grillz -D                  # jump to Drinks
  grillz new "Dir brute" "gobuster dir -u <url> -w <wordlist>"
  PREFIX=/usr/local grillz install
EOF
}
