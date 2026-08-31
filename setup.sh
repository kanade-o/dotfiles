#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "${OSTYPE:-}" != darwin* ]]; then
  echo "This setup script supports macOS only." >&2
  exit 1
fi

skip_packages=false
if [[ "${1:-}" == "--skip-packages" ]]; then
  skip_packages=true
elif [[ $# -ne 0 ]]; then
  echo "Usage: $0 [--skip-packages]" >&2
  exit 2
fi

link_file() {
  local source_path="$1"
  local destination_path="$2"

  mkdir -p "$(dirname "$destination_path")"

  if [[ -L "$destination_path" && "$(readlink "$destination_path")" == "$source_path" ]]; then
    return
  fi

  if [[ -e "$destination_path" || -L "$destination_path" ]]; then
    local backup_path="${destination_path}.dotfiles-backup"
    if [[ -e "$backup_path" || -L "$backup_path" ]]; then
      echo "Refusing to overwrite existing backup: $backup_path" >&2
      exit 1
    fi
    mv "$destination_path" "$backup_path"
    echo "Backed up $destination_path to $backup_path"
  fi

  ln -s "$source_path" "$destination_path"
  echo "Linked $destination_path"
}

install_packages() {
  local brew_bin

  if command -v brew >/dev/null 2>&1; then
    brew_bin="$(command -v brew)"
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ -x /opt/homebrew/bin/brew ]]; then
      brew_bin=/opt/homebrew/bin/brew
    elif [[ -x /usr/local/bin/brew ]]; then
      brew_bin=/usr/local/bin/brew
    else
      echo "Homebrew installation completed, but brew was not found." >&2
      exit 1
    fi
  fi

  eval "$("$brew_bin" shellenv)"
  brew install neovim starship
  brew install --cask wezterm font-moralerspace-hw
}

if [[ "$skip_packages" == false ]]; then
  install_packages
fi

link_file "$repo_root/.config/nvim" "$HOME/.config/nvim"
link_file "$repo_root/.config/wezterm" "$HOME/.config/wezterm"
link_file "$repo_root/.config/starship.toml" "$HOME/.config/starship.toml"
link_file "$repo_root/zsh/zshrc" "$HOME/.zshrc"
link_file "$repo_root/zsh/zprofile" "$HOME/.zprofile"

echo "Dotfiles setup complete."
