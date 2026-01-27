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
echo "1. Install office fonts"
echo "2. Install Hatter icons"
echo "3. Configure the Flathub repository"
echo "4. Replace RPM apps with Flatpak equivalents"
echo "5. Apply GTK theme for better visual integration"
echo ""

read -p "Continue? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Operation cancelled by user."
    exit 0
fi

# 2. Instalação das fontes do Office

echo ""
echo "📄 Instalando fontes Office na pasta do usuário..."

FONTS_DIR="$HOME/.local/share/fonts/office_fonts"
TMP_ZIP="/tmp/office_fonts.zip"

mkdir -p "$FONTS_DIR"

curl -fsSL https://raw.githubusercontent.com/diogopessoa/my-packages-lists/main/silverblue/office_fonts.zip -o "$TMP_ZIP"

unzip -o "$TMP_ZIP" "*.ttf" -d "$FONTS_DIR"

fc-cache -f "$HOME/.local/share/fonts"

rm -f "$TMP_ZIP"

echo ""
echo ">> Fontes Office instaladas com sucesso!"


# 3. Tema de Ícones Hatter

echo ""
echo "🎨 Instalando os Ícones Hatter..."

ICONS_DIR="$HOME/.local/share/icons"
HATTER_DIR="$HOME/Downloads/Hatter"

rm -rf "$HATTER_DIR"
git clone https://github.com/Mibea/Hatter.git "$HATTER_DIR"

mkdir -p "$ICONS_DIR"

# Copia apenas os variantes desejados
cp -r "$HATTER_DIR/Hatter" "$ICONS_DIR/"

# Atualiza cache
gtk-update-icon-cache "$ICONS_DIR/Hatter" || true

# Aplica o tema de ícones Hatter
gsettings set org.gnome.desktop.interface icon-theme 'Hatter'

flatpak override --user --filesystem=xdg-config/gtk-3.0
flatpak override --user --filesystem=xdg-config/gtk-4.0

rm -rf "$HATTER_DIR"
echo ""
echo ">> Hatter instalado com sucesso!"

# Encerra o gnome-software para evitar conflitos
pkill -f gnome-software || true

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
lista_apps=(
  org.gnome.baobab
  org.gnome.Calculator
  org.gnome.Calendar
  org.gnome.clocks
  org.gnome.Contacts
  org.gnome.Connections
  org.fedoraproject.MediaWriter
  org.gnome.font-viewer
  org.gnome.FileRoller
  org.gnome.Loupe
  org.gnome.Papers
  org.gnome.SimpleScan
  org.gnome.Snapshot
  org.gnome.Showtime
  org.gnome.TextEditor
  org.onlyoffice.desktopeditors
  it.mijorus.smile
  io.missioncenter.MissionCenter
  com.github.neithern.g4music
  com.mattjakeman.ExtensionManager
  com.brave.Browser
  page.tesk.Refine
  org.localsend.localsend_app
  page.codeberg.libre_menu_editor.LibreMenuEditor
)

for app in "${lista_apps[@]}"; do
  flatpak install --system --assumeyes flathub "$app" \
    || echo "Warning: $app not available on Flathub."
done

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
