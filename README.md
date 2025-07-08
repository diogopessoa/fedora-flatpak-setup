# Fedora Flatpak Setup

O tutorial a seguir substitui aplicações RPM do Fedora por Flatpak (Flathub), proporcionando melhor isolamento e atualizações mais consistentes.

## 📦 Aplicações convertidas

* GNOME Core Apps (Calendar, Contacts, Maps, Weather, etc.)

## 🔧 Requisitos

* Fedora Workstation


## Lista de aplicativos que será instalado:
 

| ID application                                   | Nome                               |
|-------------------------------------------------|----------------------------------|
| app.devsuite.Ptyxis                             | Ptyxis                           |
| be.alexandervanhee.gradia                       | Gradia                          |
| com.bitwarden.desktop                           | Bitwarden                      |
| com.calibre_ebook.calibre                       | calibre                        |
| com.github.jeromerobert.pdfarranger             | PDF Arranger                   |
| com.github.neithern.g4music                     | Gapless                       |
| com.github.PintaProject.Pinta                    | Pinta                         |
| com.mattjakeman.ExtensionManager                | Gerenciador de Extensões       |
| com.protonvpn.www                               | Proton VPN                    |
| com.vivaldi.Vivaldi                             | Vivaldi                       |
| com.warlordsoftwares.youtube-downloader-4ktube | 4KTUBE                        |
| de.haeckerfelix.Fragments                       | Fragments                     |
| garden.jamie.Morphosis                          | Morphosis                     |
| io.ente.auth                                    | Ente Auth                     |
| io.github.celluloid_player.Celluloid            | Reprodutor de Multimídia Celluloid |
| io.github.dvlv.boxbuddyrs                       | BoxBuddy                      |
| net.cozic.joplin_desktop                        | Joplin                        |
| org.freefilesync.FreeFileSync                   | FreeFileSync                  |
| org.gnome.baobab                                | Analisador de uso de disco    |
| org.gnome.Calculator                            | Calculadora                   |
| org.gnome.Calendar                              | Calendário                   |
| org.gnome.Characters                            | Caracteres                   |
| org.gnome.clocks                                | Relógios                     |
| org.gnome.Connections                           | Conexões                     |
| org.gnome.Evince                                | Visualizador de documentos   |
| org.gnome.font-viewer                           | Fontes                       |
| org.gnome.gitlab.YaLTeR.VideoTrimmer            | Video Trimmer                |
| org.gnome.gThumb                                | Visualizador de imagens gThumb |
| org.gnome.Logs                                  | Logs                         |
| org.gnome.Loupe                                 | Visualizador de imagens      |
| org.gnome.SimpleScan                            | Digitalizador de documentos  |
| org.gnome.Snapshot                              | Câmera                       |
| org.gnome.Solanum                               | Solanum                      |
| org.gnome.SoundRecorder                         | Gravador de som              |
| org.gnome.TextEditor                            | Editor de Texto              |
| org.onlyoffice.desktopeditors                   | ONLYOFFICE Desktop Editors   |
| org.telegram.desktop                            | Telegram                    |
| org.upscayl.Upscayl                            | Upscayl                     |
| page.codeberg.libre_menu_editor.LibreMenuEditor | Menu Principal               |


Essa lista poderá ser atualizada conforme mudar a base de aplicações [GNOME Core](https://apps.gnome.org/).

### ✨ Recursos

- Remove os aplicativos RPM
- Instala os aplicativos Flatpak 
- Repoitório Flathub como prioridade máxima
- Tema ADW GTK3 para melhor integração visual com GNOME

## 🚀 Instalação automática (execute o script)

Passo a Passo:

1. Baixe ou clone o script do GitHub:
   ```bash
   wget https://raw.githubusercontent.com/diogopessoa/fedora-flatpak-setup/main/fedora-flatpak-setup.sh
   ```

2. Torne-o executável:

   ```bash
   chmod +x fedora-flatpak-setup.sh
   ```

3. Execute com privilégios de superusuário:

   ```bash
   sudo ./fedora-flatpak-setup.sh
   ```

Pronto! Se tudo deu certo você receberá a mensagem "✅ Processo concluído com sucesso!".

# 🔨 Instalação Manual (opcional alternativa)

## 1. Desinstalar os aplicativos RPM no GNOME Software 
- Abra o GNOME Software (Programas)
  - clique em 'Instalados'
  - remova os aplicativos RPM manualemente

## 2. Verificar se o repositório Flathub está habilitado:

- Habilitar o Flathub
```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

- Priorizar Flatpak (Flathub) para GNOME Software
```bash
sudo flatpak remote-modify --system --prio=1 flathub
```

- Copie e cole no terminal para instalar os aplicativos:

```bash
flatpak install flathub --assumeyes --noninteractive app.devsuite.Ptyxis be.alexandervanhee.gradia com.bitwarden.desktop com.calibre_ebook.calibre com.github.jeromerobert.pdfarranger com.github.neithern.g4music com.github.PintaProject.Pinta com.mattjakeman.ExtensionManager com.protonvpn.www com.vivaldi.Vivaldi com.warlordsoftwares.youtube-downloader-4ktube de.haeckerfelix.Fragments garden.jamie.Morphosis io.ente.auth io.github.celluloid_player.Celluloid io.github.dvlv.boxbuddyrs net.cozic.joplin_desktop org.freefilesync.FreeFileSync org.gnome.baobab org.gnome.Calculator org.gnome.Calendar org.gnome.Characters org.gnome.clocks org.gnome.Connections org.gnome.Evince org.gnome.font-viewer org.gnome.gitlab.YaLTeR.VideoTrimmer org.gnome.gThumb org.gnome.Logs org.gnome.Loupe org.gnome.SimpleScan org.gnome.Snapshot org.gnome.Solanum org.gnome.SoundRecorder org.gnome.TextEditor org.onlyoffice.desktopeditors org.telegram.desktop org.upscayl.Upscayl page.codeberg.libre_menu_editor.LibreMenuEditor
```



## 3. Ajuste de Tema GTK para aplicações Flatpak


- Instalar o tema
```bash
sudo dnf install adw-gtk3-theme
```

- Aplicar o tema
```bash
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
```

- Concluir a configuração
```bash
flatpak update
```

É isso!

## 📄 Licença

[Creative Commons Zero v1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/deed.pt-br) — livre para uso, modificação e distribuição.

