
#!/usr/bin/env bash

set -euo pipefail

REPO_URL="https://github.com/brandonyoungdev/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup"

config() {
  git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

backup_conflicts() {
  local checkout_output="$1"
  local line
  local path
  local source_path
  local backup_path
  local moved_any=1

  while IFS= read -r line; do
    path="${line#"${line%%[![:space:]]*}"}"

    if [[ -z "$path" ]]; then
      continue
    fi

    source_path="$HOME/$path"
    if [[ ! -e "$source_path" && ! -L "$source_path" ]]; then
      continue
    fi

    backup_path="$BACKUP_DIR/$path"
    mkdir -p "$(dirname "$backup_path")"
    mv "$source_path" "$backup_path"
    printf 'Backed up %s to %s\n' "$source_path" "$backup_path"
    moved_any=0
  done <<< "$checkout_output"

  return "$moved_any"
}

if [[ ! -d "$DOTFILES_DIR" ]]; then
  git clone --bare "$REPO_URL" "$DOTFILES_DIR"
elif ! git --git-dir="$DOTFILES_DIR" rev-parse --is-bare-repository >/dev/null 2>&1; then
  echo "$DOTFILES_DIR exists but is not a bare git repository." >&2
  exit 1
fi

mkdir -p "$BACKUP_DIR"

if checkout_output="$(config checkout 2>&1)"; then
  printf 'Checked out dotfiles from %s\n' "$REPO_URL"
else
  printf '%s\n' "$checkout_output"
  printf 'Moving conflicting files to %s\n' "$BACKUP_DIR"

  if ! backup_conflicts "$checkout_output"; then
    echo "Unable to automatically resolve checkout conflicts." >&2
    exit 1
  fi

  config checkout
  printf 'Checked out dotfiles from %s\n' "$REPO_URL"
fi

config config status.showUntrackedFiles no
