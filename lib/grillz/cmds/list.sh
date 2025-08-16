#!/usr/bin/env bash
grillz::cmd_list() {
  local base="$GRILLZ_PANTRY_DEFAULT"
  grillz::list_recipe_files \
    | sed "s|^$base/||" \
    | LC_ALL=C sort \
    | sed "s|^|${base/#$HOME/~}/|"
}
