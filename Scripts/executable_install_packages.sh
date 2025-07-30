#!/bin/bash

packages=(
    # == CORE ==
    hyprland
    hyprpolkitagent
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    kitty
    networkmanager
    pipewire
    wireplumber
    bluez
    qt5-wayland
    qt6-wayland
    greetd

    # == UTILS ==
    # Hypr ecosystem
    hyprlock
    hypridle
    hyprpicker
    hyprsunset
    hyprpaper
    # DE Stuff
    rofi-wayland
    waybar
    swww
    swaync
    greetd-tuigreet
    # Text editors
    neovim
    nano
    # File managers
    thunar
    dolphin
    yazi
    # GUI config
    qt5ct
    qt6ct
    nwg-look

    # == EXTRAS ==
    steam
    discord
)

# == AUR ==
aur_packages=(
    python-pywal16
    zen-browser-bin
    visual-studio-code-bin
    waypaper
)

# install packages
#all_packages=("${core_packages[@]}" "${utils[@]}" "${extras[@]}")
echo -e "\n=== Installing Pacman Packages... ==="
sudo pacman -S --needed "${packages[@]}"

# fonts
echo -e "\n=== Installing Fonts... ==="
sudo pacman -S --needed --noconfirm $(pacman -Ssq noto-fonts) ttf-jetbrains-mono-nerd

# yay setup
echo -e "\n=== Checking Yay... ==="
    if ! command -v yay $>/dev/null; then
    echo -e "\n=== Installing Yay... ==="
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    rm -rf yay
else
    echo "=== Yay is already installed. ==="
fi

# install aur packages
echo -e "\n=== Installing AUR Packages... ==="
yay -S --needed --answerdiff None --answerclean None --removemake "${aur_packages[@]}"
