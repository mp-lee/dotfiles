#!/bin/bash

# check OS
source /etc/os-release
packages=(git lazygit git-delta git-credential-libsecret \
 nano neovim zoxide fish zsh stow fzf ripgrep ncdu duf tmux dust conky fd)

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
	packages=( "${packages[@]/dust/du-dust}" )
	packages=( "${packages[@]/fd/fd-find}" )
	packages=( "${packages[@]/conky/conky-all}" )
        ;;
esac

echo "Installing packages.."
for package in ${packages[@]};
 do sudo "$PKG" install -y $package;
done

pushd $HOME/dotfiles >/dev/null
	stow --adopt .
popd >/dev/null
