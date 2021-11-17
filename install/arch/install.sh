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

AURMAN=""
for aurman in yay paru
do
  if command -v $aurman &> /dev/null
  then
    AURMAN=$aurman
  fi
done
if [[ -z $AURMAN ]]
then
  echo "No aur manager was found. Please install one to continue"
  exit 1
fi

echo "Updating packages before installing dotfiles"
sudo pacman -Syu --noconfirm

pushd() {
  command pushd "$@" > /dev/null
}

popd() {
  command popd "$@" > /dev/null
}

_is_installed() {
  pacman -Qi $1 > /dev/null
  echo $?
}

echo "Installing packages"
toinstall=()
for pkg in alacritty bat cmake curl docker docker-compose exa fd fzf git git-lfs github-cli htop ksshaskpass lolcat luajit luarocks neofetch neovim ninja openssh ripgrep starship stow tmux wget zsh ueberzug --noconfirm
do
  if [[ $(_is_installed $pkg) == 0 ]]; then
    continue
  fi
  toinstall+=($pkg)
done
if [[ $(pacman -Qg base-devel | wc -l) != 24 ]]; then
  toinstall+=("base-devel")
fi
if [[ "${toinstall[@]}" == "" ]]; then
  echo "All packages are already installed"
else
  sudo pacman -S "${toinstall[@]}" --noconfirm
fi

echo "Backing up existing files"
BACKUP_DIR=$HOME/.dotfiles-backup
if [ ! -d $BACKUP_DIR ]; then
  mkdir $BACKUP_DIR
fi
for item in .zshrc .config/starship.toml .config/alacritty .dircolors .tmux.conf .config/nvim .gitconfig
do
  if test -e $HOME/$item; then
    echo "Backing up $item"
    mv $HOME/$item $BACKUP_DIR/
  fi
done

echo "Downloading dotfiles"
if [ -d $HOME/.dotfiles ]; then
  echo "Please remove existing .dotfiles before installing these ones"
  exit 1
else
  pushd $HOME
  gh repo clone ozokuz/dotfiles .dotfiles
  popd
fi

echo "Installing dotfiles"
pushd $HOME/.dotfiles/linux
for item in alacritty dircolors git nvim tmux zsh
do
  echo "Installing $item config"
  stow -t $HOME $item
done
pushd ../global
stow -t $HOME starship
popd
popd

echo "Making local folders"
mkdir -p $HOME/.local/{bin,src}

echo "Installing nvm"
curl -fsSLo- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | PROFILE=/dev/null bash
NVM_DIR="$([ -z "${XDG_CONFIG_HOME}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "Installing Node 16"
nvm install 16

echo "Installing development tools"
npm i -g typescript prettier @angular/cli nx @nestjs/cli @vue/cli firebase-tools yarn

