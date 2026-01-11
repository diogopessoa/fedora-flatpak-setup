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
    firefox \
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
flatpak install flathub --assumeyes --noninteractive com.brave.Browser app.devsuite.Ptyxis com.mattjakeman.ExtensionManager net.nokyan.Resources org.gnome.baobab org.gnome.Boxes org.gnome.Calculator org.gnome.Calendar org.gnome.Characters org.gnome.clocks org.gnome.Contacts org.gnome.Decibels org.gnome.font-viewer org.gnome.Logs org.gnome.Loupe org.gnome.Maps org.gnome.Papers org.gnome.Showtime org.gnome.SimpleScan org.gnome.Snapshot org.gnome.TextEditor org.gnome.Weather page.tesk.Refine "${apps[@]}"

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
echo "✅ Process successfully completed!"
echo "🔁 Restart the system to apply all changes."
echo "=============================================="
