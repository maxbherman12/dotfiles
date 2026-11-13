#!/usr/bin/env bash
#
# Symlink these dotfiles into $HOME using GNU stow.
#
# Usage:
#   ./install.sh                 link every package
#   ./install.sh nvim ghostty    link only these packages
#   ./install.sh --brew          install Brewfile apps first, then link everything
#
# If a real file is already where a symlink needs to go, it is renamed to
# <file>.bak-<timestamp> so nothing is lost.

set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
PACKAGES=(zsh git bin starship nvim ghostty lazygit)
STAMP="$(date +%Y%m%d-%H%M%S)"

say() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
die() { printf '\033[1;31merror:\033[0m %s\n' "$*" >&2; exit 1; }

# Rename a real file out of the way (leaves symlinks alone).
backup() {
  local file="$1"
  # Skip files that already resolve into this repo (e.g. via a folded
  # directory symlink like ~/.config/nvim -> dotfiles/nvim/.config/nvim).
  local real_dir
  real_dir="$(cd "$(dirname "$file")" 2>/dev/null && pwd -P)" || return 0
  [[ "$real_dir/" == "$(cd "$DOTFILES" && pwd -P)/"* ]] && return 0
  if [[ -e "$file" && ! -L "$file" ]]; then
    say "Backing up $file -> $file.bak-$STAMP"
    mv "$file" "$file.bak-$STAMP"
  fi
}

# Install Brewfile entries one at a time so there's a visible [n/total] counter
# and brew's own download progress bars (which `brew bundle` hides).
install_brew_packages() {
  command -v brew >/dev/null || die "Homebrew not found. Install it from https://brew.sh"

  # Homebrew 7+ asks for confirmation before every install by default; skip that.
  export HOMEBREW_NO_ASK=1

  local formulae casks installed_formulae installed_casks
  formulae=$(brew bundle list --formula --file="$DOTFILES/Brewfile")
  casks=$(brew bundle list --cask --file="$DOTFILES/Brewfile")
  installed_formulae=$(brew list --formula -1)
  installed_casks=$(brew list --cask -1)

  local total i=0 failed=()
  total=$(printf '%s\n%s\n' "$formulae" "$casks" | grep -c .)
  say "Installing $total Brewfile packages"

  local name
  for name in $formulae; do
    i=$((i + 1))
    if grep -qx "$name" <<<"$installed_formulae"; then
      printf '[%d/%d] %s (already installed)\n' "$i" "$total" "$name"
    else
      say "[$i/$total] Installing $name"
      brew install --yes "$name" || failed+=("$name")
    fi
  done
  for name in $casks; do
    i=$((i + 1))
    if grep -qx "$name" <<<"$installed_casks"; then
      printf '[%d/%d] %s (already installed)\n' "$i" "$total" "$name"
    else
      say "[$i/$total] Installing $name"
      brew install --yes --cask --adopt "$name" || failed+=("$name")
    fi
  done

  # Don't abort the whole run if one package fails.
  if [[ ${#failed[@]} -gt 0 ]]; then
    say "These failed (see output above), continuing anyway: ${failed[*]}"
  fi
}

link_package() {
  local pkg="$1"
  [[ -d "$DOTFILES/$pkg" ]] || die "No package named '$pkg'"

  # Move aside any real files this package would replace.
  while IFS= read -r file; do
    backup "$HOME/$file"
  done < <(cd "$DOTFILES/$pkg" && find . -type f | sed 's|^\./||')

  # Ghostty on macOS also reads this file, and it overrides ~/.config/ghostty.
  if [[ "$pkg" == ghostty ]]; then
    backup "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
  fi

  say "Linking $pkg"
  stow --dir="$DOTFILES" --target="$HOME" --restow "$pkg"
}

# --- main -------------------------------------------------------------------

selected=()
for arg in "$@"; do
  case "$arg" in
    --brew)    install_brew_packages ;;
    -h|--help) sed -n '3,12p' "$0"; exit 0 ;;
    *)         selected+=("$arg") ;;
  esac
done
[[ ${#selected[@]} -gt 0 ]] || selected=("${PACKAGES[@]}")

command -v stow >/dev/null || die "stow not found. Run: brew install stow  (or ./install.sh --brew)"

mkdir -p "$HOME/.config" "$HOME/.local/bin" "$HOME/projects"

for pkg in "${selected[@]}"; do
  link_package "$pkg"
done

say "Done. Open a new terminal (or run: exec zsh)"
