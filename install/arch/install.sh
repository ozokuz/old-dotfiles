#!/bin/bash
read -r -d '' BANNER << EOF
.  ____              __        _          ____        __  _____ __
  / __ \____  ____  / /____  _( )_____   / __ \____  / /_/ __(_) /__  _____
 / / / /_  / / __ \/ //_/ / / /// ___/  / / / / __ \/ __/ /_/ / / _ \/ ___/
/ /_/ / / /_/ /_/ / ,< / /_/ / (__  )  / /_/ / /_/ / /_/ __/ / /  __(__  )
\____/ /___/\____/_/|_|\__,_/ /____/  /_____/\____/\__/_/ /_/_/\___/____/

EOF

set -e

clear

echo -e "$BANNER"

pushd() {
  command pushd "$@" > /dev/null
}

popd() {
  command popd "$@" > /dev/null
}

echon() {
  echo -e "\n$@"
}

_is_installed() {
  pacman -Qi $1 &> /dev/null
  echo $?
}

echon "Updating packages before installing dotfiles"
sudo pacman -Syu --noconfirm

echon "Making local bin folder"
mkdir -p $HOME/.local/bin

if ! command -v yay &> /dev/null; then
  echon "Installing yay as an aur manager as it wasn't found"
  pushd /tmp
  git clone https://aur.archlinux.org/yay.git
  pushd yay
  makepkg -si
  popd
  rm -rf yay
  popd
fi

echon "Installing system packages"
toinstall=()
for pkg in alacritty bat cmake curl docker docker-compose exa fd fzf git git-lfs github-cli htop ksshaskpass lolcat luajit luarocks neofetch neovim ninja openssh p7zip ripgrep starship stow tmux wget zsh ueberzug --noconfirm
do
  if [[ "$(_is_installed $pkg)" == "0" ]]; then
    continue
  fi
  toinstall+=($pkg)
done
if [[ $(pacman -Qg base-devel | wc -l) != 24 ]]; then
  toinstall+=("base-devel")
fi
if [[ "${toinstall[@]}" != "" ]]; then
  sudo pacman -S "${toinstall[@]}" --noconfirm --needed
fi

echo "Installing aur packages"
toinstall=()
for pkg in brave-bin google-chrome nerd-fonts-fira-code visual-studio-code-bin; do
  if [[ "$(_is_installed $pkg)" == "0" ]]; then
    continue
  fi
  toinstall+=($pkg)
done
if [[ "${toinstall[@]}" != "" ]]; then
  yay -S "${toinstall[@]}" --noconfirm --needed
fi

echon "Backing up existing files"
BACKUP_DIR=$HOME/.dotfiles-backup
if [ ! -d $BACKUP_DIR ]; then
  mkdir $BACKUP_DIR
fi
for item in .zshrc .config/starship.toml .config/alacritty .dircolors .tmux.conf .config/nvim .gitconfig .config/plasma-workspace/env/askpass.sh .config/autostart/ssh-add.desktop .config/systemd/user/ssh-agent.service
do
  if test -e $HOME/$item; then
    echo "Backing up $item"
    mv $HOME/$item $BACKUP_DIR/
  fi
done

echon "Downloading the dotfiles repo"
if [ -d $HOME/.dotfiles ]; then
  echo "Please remove existing .dotfiles before installing these ones"
  exit 1
else
  pushd $HOME
  git clone https://github.com/ozokuz/dotfiles .dotfiles
  popd
fi

echon "Installing dotfiles"
pushd $HOME/.dotfiles/linux
for item in alacritty dircolors git nvim tmux zsh plasma
do
  echo "Installing $item config"
  stow -t $HOME $item
done
pushd ../global
echo "Installing starship config"
stow -t $HOME starship
popd
popd

echon "Installing zplug"
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

echon "Installing sdkman"
curl -s "https://get.sdkman.io" | bash

echon "Enabling ssh-agent service for current user"
systemctl enable ssh-agent --user

echon "Installing pnpm"
curl -fsSL https://get.pnpm.io/install.sh | sh -
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

echon "Installing Node 16"
pnpm env use --global 16

echon "Installing development tools"
pnpm add -g nx@latest yarn@latest npm@latest

echon "Changing default shell to zsh"
chsh -s /bin/zsh

