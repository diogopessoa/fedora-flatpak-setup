# Fedora Flatpak Setup

The following tutorial replaces Fedora RPM applications with Flatpak (Flathub), providing better isolation and more consistent updates.

<table>
  <tr>
    <td><img src="https://fedoraproject.org/w/uploads/2/2d/Logo_fedoralogo.png" width="150" /></td>
    <td><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Flatpak_Logo.svg/640px-Flatpak_Logo.svg.png" width="150" /></td>
    <td><img src="https://apps.gnome.org/assets/overview-illustration/disability-pride-month.svg" width="150" /></td>
  </tr>
</table>



## 📦 Converted Applications

* GNOME Core Apps (Calendar, Contacts, Maps, Weather, etc.)

## 🔧 Requirements

* Fedora Workstation


## List of applications that will be installed:
 


| ID application                        | Name                  |
|----------------------------------------|-----------------------|
| org.gnome.Boxes                       | Boxes                 |
| org.gnome.Calculator                   | Calculator            |
| org.gnome.Calendar                     | Calendar              |
| org.gnome.Characters                   | Characters            |
| org.gnome.clocks                       | Clocks                |
| org.gnome.Contacts                     | Contacts              |
| org.gnome.Decibels                     | Audio Player          |
| org.gnome.baobab                       | Disk Usage Analyzer   |
| org.gnome.SimpleScan                   | Document Scanner      |
| org.gnome.Papers                       | Document Viewer       |
| org.gnome.font-viewer                  | Fonts                 |
| org.gnome.Logs                         | Logs                  |
| org.gnome.Loupe                        | Image Viewer          |
| org.gnome.Maps                         | Maps                  |
| net.nokyan.Resources                   | Resources             |
| org.gnome.Showtime                     | Videos                |
| org.gnome.TextEditor                   | Text Editor           |
| app.devsuite.Ptyxis                    | Ptyxis                |
| org.gnome.Weather                      | Weather               |
| org.gnome.Snapshot                     | Screenshot            |
| com.mattjakeman.ExtensionManager        | Extensions            |
| page.tesk.Refine                       | Refine                |



This list can be updated as it changes the application base of [GNOME Core](https://apps.gnome.org/).

### ✨ Features

- **Removes RPM applications and Installs Flatpak versions**  
  Replaces RPM apps with Flatpak packages, ensuring better sandboxing and more frequent updates.

- **Sets Flathub as the highest priority repository**  
  Configures Flatpak to prioritize Flathub, the largest and most reliable source of GNOME apps.

- **Applies the ADW GTK3 theme**  
  Installs and enables the ADW GTK3 theme for a seamless and visually consistent experience with GNOME. 

## 🚀 Automatic Installation (run the script)

Step by step:

1. Download or clone the script from GitHub:

   ```bash
   cd ~/Downloads
   wget https://raw.githubusercontent.com/diogopessoa/fedora-flatpak-setup/main/fedora-flatpak-setup.sh
   ```

3. Make it executable:

   ```bash
   chmod +x fedora-flatpak-setup.sh
   ```

4. Run with superuser privileges:

   ```bash
   sudo ./fedora-flatpak-setup.sh
   ```

Done! If everything went well, you will receive the message "✅ Process completed successfully!".

# 🔨 Manual Installation (alternative)

## 1. Uninstall RPM applications in GNOME Software  
- Open GNOME Software (Programs)  
  - click on 'Installed'  
  - manually remove the RPM applications 

## 2. Check if the Flathub repository is enabled:

- Enable Flathub
```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

- Prioritize Flatpak (Flathub) for GNOME Software
```bash
sudo flatpak remote-modify --system --prio=1 flathub
```

- Copy and paste in the terminal to install the applications:

```bash
flatpak install flathub --assumeyes --noninteractive app.devsuite.Ptyxis com.mattjakeman.ExtensionManager net.nokyan.Resources org.gnome.baobab org.gnome.Boxes org.gnome.Calculator org.gnome.Calendar org.gnome.Characters org.gnome.clocks org.gnome.Contacts org.gnome.Decibels org.gnome.font-viewer org.gnome.Logs org.gnome.Loupe org.gnome.Maps org.gnome.Papers org.gnome.Showtime org.gnome.SimpleScan org.gnome.Snapshot org.gnome.TextEditor org.gnome.Weather page.tesk.Refine
```



## 3. GTK Theme adjustment for Flatpak applications


- Install the theme
```bash
sudo dnf install adw-gtk3-theme
```

- Apply the theme
```bash
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
```

- Finish the setup
```bash
flatpak update
```

That's it!

## 📄 License

[Creative Commons Zero v1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/deed.pt-br) — free for use, modification and distribution..

