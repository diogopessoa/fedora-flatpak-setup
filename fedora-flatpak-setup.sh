#!/bin/bash

# Fedora Flatpak Setup Script
# Author: Diogo Pessoa
# License: MIT

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Try: sudo $0"
    exit 1
fi

# Check if flatpak is installed
if ! command -v flatpak &>/dev/null; then
    echo "🔍 Flatpak is not installed. Installing it now..."
    dnf install -y flatpak
    echo "✅ Flatpak installed successfully."
fi

# Welcome message
echo "=============================================="
echo "     Fedora Flatpak Setup Script"
echo "=============================================="
echo ""
echo "This script will:"
echo "1. Configure the Flathub repository"
echo "2. Replace RPM apps with Flatpak equivalents"
echo "3. Apply GTK theme for better visual integration"
echo ""

read -p "Continue? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Operation cancelled by user."
    exit 0
fi

# Step 1 – Configure Flathub
echo -e "\n🔧 Setting up Flathub..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-modify --system --prio=1 flathub

# Step 2 – Remove default RPM apps (ignore missing)
echo -e "\n🧹 Removing default RPM applications..."
dnf remove -y \
    gnome-calendar \
    gnome-contacts \
    gnome-maps \
    gnome-music \
    gnome-photos \
    gnome-weather \
    gnome-system-monitor \
    papers \
    evince \
    decibels \
    totem \
    cheese \
    rhythmbox \
    ptyxis 2>/dev/null || true

# Step 3 – Install Flatpak apps from Flathub
echo -e "\n📦 Installing Flatpak applications from Flathub..."
flatpak install flathub --assumeyes --noninteractive app.devsuite.Ptyxis be.alexandervanhee.gradia com.bitwarden.desktop com.calibre_ebook.calibre com.github.jeromerobert.pdfarranger com.github.neithern.g4music com.github.PintaProject.Pinta com.mattjakeman.ExtensionManager com.protonvpn.www com.vivaldi.Vivaldi com.warlordsoftwares.youtube-downloader-4ktube de.haeckerfelix.Fragments garden.jamie.Morphosis io.ente.auth io.github.celluloid_player.Celluloid io.github.dvlv.boxbuddyrs net.cozic.joplin_desktop org.freefilesync.FreeFileSync org.gnome.baobab org.gnome.Calculator org.gnome.Calendar org.gnome.Characters org.gnome.clocks org.gnome.Connections org.gnome.Evince org.gnome.font-viewer org.gnome.gitlab.YaLTeR.VideoTrimmer org.gnome.gThumb org.gnome.Logs org.gnome.Loupe org.gnome.SimpleScan org.gnome.Snapshot org.gnome.Solanum org.gnome.SoundRecorder org.gnome.TextEditor org.onlyoffice.desktopeditors org.telegram.desktop org.upscayl.Upscayl page.codeberg.libre_menu_editor.LibreMenuEditor "${apps[@]}"

# Step 4 – Apply GTK theme
echo -e "\n🎨 Applying visual theme (adw-gtk3)..."
dnf install -y adw-gtk3-theme
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'

# Step 5 – Cleanup
echo -e "\n🧼 Cleaning up..."
flatpak update -y
dnf autoremove -y
dnf clean all

# Finalização
echo ""
echo "=============================================="
echo "✅ Processo concluído com sucesso!"
echo "🔁 Reinicie o sistema para aplicar todas as alterações."
echo "=============================================="
