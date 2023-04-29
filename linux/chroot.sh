#!/bin/bash

# timezone
ln -sf /usr/share/zoneinfo/Europe/Helsinki /etc/localtime
hwclock --systohc

# language
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf

# console keymap
echo 'KEYMAP=fi' > /etc/vconsole.conf

# hostname
echo archlinux > /etc/hostname

# username:encrypted_password (encrypt with 'openssl passwd -6')
echo 'root:$6$OT.nLJZgSe/3Xd9R$fvQ4NHgqqYaXeNhujAyxalq1FwltqODBkPwBmvF0HFTrwGF3wpvw3RwNnJvES9PKbf2LHwkV6OkbZjWeUwQtS.' | chpasswd -e

# configure pacman
grep -q "ILoveCandy" /etc/pacman.conf || sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf
sed -Ei "s/^#(ParallelDownloads).*/\1 = 5/;/^#Color$/s/#//" /etc/pacman.conf
pacman -Syu --noconfirm

# install packages
pacman -S --noconfirm base-devel amd-ucode grub efibootmgr os-prober alacritty bat bc btop btrfs-progs dex discord dnsmasq docker dolphin-emu exa fd fish flameshot flatpak fzf gamemode gimp git git-delta git-lfs github-cli iptables-nft jdk17-openjdk jre8-openjdk lazygit lf lib32-gamemode libfido2 libretro-desmume libretro-genesis-plus-gx lutris lxqt-openssh-askpass lxsession-gtk3 maim man-db man-pages mpv neofetch neovim networkmanager noto-fonts-emoji noto-fonts ntfs-3g nvidia nvidia-settings nvidia-utils lib32-nvidia-utils nvtop pacman-contrib pamixer pavucontrol picom pinta piper pipewire pipewire-alsa pipewire-jack pipewire-pulse playerctl plocate pulsemixer qemu-desktop qpwgraph redshift retroarch retroarch-assets-ozone ripgrep rofi screenkey sddm starship steam stow sudo sxiv thunar thunar-archive-plugin tmux ttf-liberation unzip virt-manager wireplumber xclip xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-gnome xdg-user-dirs xdotool xorg zathura

# install bootloader
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=ARCH
grub-mkconfig -o /boot/grub/grub.cfg

# enable network manager
systemctl enable NetworkManager
# enable login screen
systemctl enable sddm

# create user
useradd -m -G wheel -s /bin/fish ozoku

# username:encrypted_password (encrypt with 'openssl passwd -6')
echo 'ozoku:$6$OT.nLJZgSe/3Xd9R$fvQ4NHgqqYaXeNhujAyxalq1FwltqODBkPwBmvF0HFTrwGF3wpvw3RwNnJvES9PKbf2LHwkV6OkbZjWeUwQtS.' | chpasswd -e

# sudo without password during install
trap 'rm -f /etc/sudoers.d/ozoku-temp' HUP INT QUIT TERM PWR EXIT
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >/etc/sudoers.d/ozoku-temp

# install aur helper
sudo -u ozoku git -C /tmp clone --depth 1 --single-branch --no-tags -q "https://aur.archlinux.org/yay.git" /tmp/yay
cd /tmp/yay
sudo -u ozoku makepkg --noconfirm -si

# install aur packages
sudo -u ozoku yay -S --noconfirm adw-gtk3 authy awesome-git betterlockscreen blockbench-bin brave-bin ckb-next ftba jetbrains-toolbox notion-app osu-lazer-bin packwiz-bin-git prismlauncher protonup-qt-bin spotify ticktick visual-studio-code-bin

# setup user folders
sudo -u ozoku mkdir -p /home/ozoku/{.local/{bin,src,share,state/ssh},.config,src}

# setup dotfiles
cd /home/ozoku/.local/src
sudo -u ozoku git clone https://github.com/ozokuz/dotfiles /home/ozoku/.local/src/dotfiles
cd /home/ozoku/.local/src/dotfiles/linux

for folder in alacritty awesome ckb-next discord fish git shell tmux; do
	sudo -u ozoku stow -t /home/ozoku $folder
done

cd /home/ozoku/.local/src/dotfiles/global
sudo -u ozoku stow -t /home/ozoku starship

