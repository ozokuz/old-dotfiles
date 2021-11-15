#!/bin/bash
read -r -d '' BANNER << EOF
   ____              __        _          ____        __  _____ __         
  / __ \____  ____  / /____  _( )_____   / __ \____  / /_/ __(_) /__  _____
 / / / /_  / / __ \/ //_/ / / /// ___/  / / / / __ \/ __/ /_/ / / _ \/ ___/
/ /_/ / / /_/ /_/ / ,< / /_/ / (__  )  / /_/ / /_/ / /_/ __/ / /  __(__  ) 
\____/ /___/\____/_/|_|\__,_/ /____/  /_____/\____/\__/_/ /_/_/\___/____/

EOF

set -e

clear

echo -e "$BANNER"

echo "Updating packages before installing dotfiles"
sudo pacman -Syu

echo "Installing packages"
sudo pacman -S alacritty base-devel bat cmake curl docker docker-compose exa fd fzf git git-lfs github-cli htop ksshaskpass lolcat luajit luarocks neofetch neovim ninja openssh ripgrep starship stow tmux wget zsh ueberzug

echo "Backing up existing files"
pushd $HOME
BACKUP_DIR=.dotfiles-backup
mkdir $BACKUP_DIR
for item in .zshrc .config/starship.toml .gitconfig
do
  if [ -f $item ]; then
    echo "Backing up $item"
    mv $item $BACKUP_DIR
  fi
done
popd

echo "Installing dotfiles"
pushd $HOME/.dotfiles/linux
for item in alacritty dircolors git neovim tmux zsh
do
  echo "Installing $item config"
  stow -t $HOME $item
done
popd

echo "Making local folders"
mkdir -p $HOME/.local/{bin,src}

echo "Installing nvm"
curl -fsSLo- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | PROFILE=/dev/null bash > /dev/null
NVM_DIR="$([ -z "${XDG_CONFIG_HOME}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "Installing Node 16"
nvm install 16

echo "Installing development tools"
npm i -g typescript prettier @angular/cli nx @nestjs/cli @vue/cli firebase-tools yarn

