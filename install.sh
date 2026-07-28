#!/bin/bash

# check OS
source /etc/os-release
packages=(git lazygit git-delta git-credential-libsecret \
 nano neovim zoxide fish zsh stow fzf ripgrep ncdu duf tmux dust conky fd)

OS=$(echo $ID | tr '[:upper:]' '[:lower:]')

case "$OS" in
    *"arch"*)
	INSTALL="pacman -S --noconfirm"
	;;
    *"opensuse"*)
        INSTALL="zypper in -y"
        ;;
    *"fedora"* | *"alma"*)
        INSTALL="dnf install -y"
        sudo dnf install -y epel-release
        ;;
    *)
        INSTALL="apt install -y"
	packages=( "${packages[@]/dust/du-dust}" )
	packages=( "${packages[@]/fd/fd-find}" )
	packages=( "${packages[@]/conky/conky-all}" )
        ;;
esac

echo "Installing packages.."
for package in ${packages[@]};
 do sudo $INSTALL $package;
done

pushd $HOME/dotfiles >/dev/null
	stow --adopt .
popd >/dev/null
