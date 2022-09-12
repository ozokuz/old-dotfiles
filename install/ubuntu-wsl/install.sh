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
  echo "\n$@"
}

_is_installed() {
  dpkgout="$(dpkg -l $1)"
  if [[ "$?" == "0" ]]; then
    echo $dpkgout | grep $1 | awk '{print $1}' | grep ^i > /dev/null
  fi
  echo $?
}

echon "Updating packages before installing dotfiles"
sudo apt-get update && sudo apt-get upgrade -y

echon "Making local folders"
mkdir -p $HOME/.local/bin

echon "Installing system packages"
toinstall=()
for pkg in build-essential ninja-build cmake curl fzf git-lfs neofetch ripgrep stow tmux wget zsh
do
  if [[ "$(_is_installed $pkg)" == "0" ]]; then
    continue
  fi
  toinstall+=($pkg)
done
if [[ "${toinstall[@]}" != "" ]]; then
  sudo apt-get install "${toinstall[@]}" -y
fi

if ! command -v cargo &> /dev/null; then
  echon "Installing rust with rustup"
  curl https://sh.rustup.rs -sSf | sh -s -- -y -q
fi

echon "Installing rust based system utilities"
source $HOME/.cargo/env
cargo install fd-find
cargo install exa
cargo install bat

echon "Installing starship prompt"
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -b $HOME/.local/bin -y &> /dev/null

echon "Installing neovim"
pushd $HOME/.local/bin
wget https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage
chmod +x ./nvim.appimage
ln -s nvim.appimage nvim
popd

echon "Backing up existing files"
BACKUP_DIR=$HOME/.dotfiles-backup
if [ ! -d $BACKUP_DIR ]; then
  mkdir $BACKUP_DIR
fi
for item in .zshrc .config/starship.toml .dircolors .tmux.conf .config/nvim .gitconfig
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
for item in dircolors git tmux zsh
do
  echo "Installing $item config"
  stow -t $HOME $item
done
pushd ../global
echo "Installing starship config"
stow -t $HOME starship
popd
popd

pushd $HOME/.config
git clone https://github.com/ozokuz/configs.nvim nvim
popd

echon "Installing zplug"
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

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
