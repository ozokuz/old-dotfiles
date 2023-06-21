#!/bin/bash

# timezone
ln -sf /usr/share/zoneinfo/Europe/Helsinki /etc/localtime
hwclock --systohc

# language
echo 'en_US.UTF-8 UTF-8' >>/etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' >/etc/locale.conf

# console keymap
echo 'KEYMAP=fi' >/etc/vconsole.conf

# hostname
echo cosmos >/etc/hostname

# username:encrypted_password (encrypt with 'openssl passwd -6')
echo 'root:$6$ONVZxtwYZH4IrTL4$4tRUG.KXu/bcmU4cSlNfOKb8Gk99xPm1tBW4KEyPatzyT.LcLYi1E9vj6lxxf8doNO2cTnFRbduh1k2iAlsZl/' | chpasswd -e

# configure pacman
grep -q "ILoveCandy" /etc/pacman.conf || sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf
sed -Ei "s/^#(ParallelDownloads).*/\1 = 5/;/^#Color$/s/#//" /etc/pacman.conf
sed -i '/^#\[multilib]/{N;s/\n#/\n/}' /etc/pacman.conf
sed -i 's/#\[multilib]/\[multilib]/g' /etc/pacman.conf
pacman -Syu --noconfirm

# install packages
# Base System
pacman -S --noconfirm base-devel amd-ucode grub efibootmgr os-prober btrfs-progs bluez-plugins bluez-utils fish flatpak man-db man-pages networkmanager ntfs-3g nvidia nvidia-settings nvidia-utils pacman-contrib pipewire pipewire-alsa pipewire-jack pipewire-pulse sudo texinfo wireplumber xdg-desktop-portal xdg-user-dirs xorg
# Desktop Environment
pacman -S --noconfirm blueberry breeze-gtk breeze-icons dex flameshot kvantum lxqt-openssh-askpass lxsession-gtk3 maim noto-fonts-emoji pamixer pavucontrol picom piper playerctl pulsemixer qpwgraph qt5ct redshift rofi screenkey sddm ttf-firacode-nerd ttf-liberation xclip xdg-desktop-portal-gtk xdotool
# Terminal Apps
pacman -S --noconfirm bat bc btop docker docker-compose exa fd fzf git git-delta git-lfs github-cli htop lazygit lf neofetch neovim nvtop ripgrep starship stow tmux unzip zip
# Desktop Apps
pacman -S --noconfirm alacritty bitwarden discord gimp libfido2 mpv obsidian pinta sxiv thunar thunar-archive-plugin zathura
# Gaming
pacman -S --noconfirm dolphin-emu gamemode jdk17-openjdk jre8-openjdk lib32-gamemode lib32-nvidia-utils libretro-desmume libretro-genesis-plus-gx lutris retroarch retroarch-assets-ozone steam
# Virtual Machines
pacman -S --noconfirm dnsmasq iptables-nft qemu-desktop virt-manager

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
echo 'ozoku:$6$ONVZxtwYZH4IrTL4$4tRUG.KXu/bcmU4cSlNfOKb8Gk99xPm1tBW4KEyPatzyT.LcLYi1E9vj6lxxf8doNO2cTnFRbduh1k2iAlsZl/' | chpasswd -e

# sudo without password during install
trap 'rm -f /etc/sudoers.d/ozoku-temp' HUP INT QUIT TERM PWR EXIT
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >/etc/sudoers.d/ozoku-temp

# install aur helper
sudo -u ozoku git -C /tmp clone --depth 1 --single-branch --no-tags -q "https://aur.archlinux.org/yay.git" /tmp/yay
cd /tmp/yay
sudo -u ozoku makepkg --noconfirm -si

# install aur packages
# Desktop Environment
sudo -u ozoku yay -S --noconfirm adw-gtk3 awesome-git betterlockscreen kvantum-theme-libadwaita-git
# Terminal Apps
sudo -u ozoku yay -S --noconfirm packwiz-bin-git
# Desktop Apps
sudo -u ozoku yay -S --noconfirm authy blockbench-bin brave-bin ckb-next etcher-bin jetbrains-toolbox notion-app spotify ticktick visual-studio-code-bin
# Gaming
sudo -u ozoku yay -S --noconfirm osu-lazer-bin prismlauncher-qt5-bin protonup-qt-bin

# enable sudo for wheel group
echo "%wheel ALL=(ALL:ALL) ALL" >/etc/sudoers.d/00-wheel-sudo
