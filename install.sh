#!/bin/bash

# check OS
source /etc/os-release

OS=$(echo $ID | tr '[:upper:]' '[:lower:]')

case "$OS" in
    *"opensuse"*)
        PKG=zypper
        ;;
    *"fedora"* | *"alma"*)
        PKG=dnf
        ;;
    *)
        PKG=apt
        ;;
esac

echo "Installing packages.."
sudo "$PKG" install -y stow fzf ripgrep ncdu dust duf conky fish zsh >/dev/null 2>&1

pushd $HOME/dotfiles >/dev/null
    stow --adopt .
popd >/dev/null
