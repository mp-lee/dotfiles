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
        sudo dnf install -y epel-release
        ;;
    *)
        PKG=apt
        ;;
esac

echo "Installing packages.."
for package in git nano neovim zoxide stow fzf ripgrep ncdu dust duf conky fish zsh;
 do sudo "$PKG" install -y $package;
done

pushd $HOME/dotfiles >/dev/null
    stow --adopt .
popd >/dev/null
